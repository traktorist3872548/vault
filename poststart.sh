#!/bin/bash
export VAULT_ADDR='http://127.0.0.1:8200'

if [[ ! -f /opt/vault/init.file || ! -s "/opt/vault/init.file" ]];
then
    echo "init.file not exist or empty, creating init.file"
    /opt/vault/vault operator init -key-shares=1 -key-threshold=1 | tee /opt/vault/init.file
else
   echo "vault init.file exist and not empty"
fi

echo 'export root token to env var'
export VAULT_TOKEN=$(egrep -m5 '^Initial Root Token' /opt/vault/init.file | cut -f2- -d: | tr -d ' ')

#add env var via systemd override
echo Environment=VAULT_TOKEN=${VAULT_TOKEN} >> /etc/systemd/system/vault.service.d/override.conf
systemctl daemon-reload
systemctl stop vault
systemctl start vault

echo 'unseals the vault'
egrep -m3 '^Unseal Key' /opt/vault/init.file | cut -f2- -d: | tr -d ' ' | while read key; do   /opt/vault/vault operator unseal ${key}; done
