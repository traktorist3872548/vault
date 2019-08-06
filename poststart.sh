#!/bin/bash
#export VAULT_ADDR='https://localhost:8200'
#export VAULT_CAPATH=/opt/vault/ca/certs/ca.cert.pem
chown vault:vault /opt/vault/ca/certs/ca.cert.pem
chmod 440 /opt/vault/ca/certs/ca.cert.pem

if [[ ! -f /etc/vault/init.file || ! -s "/etc/vault/init.file" ]];
then
    echo "init.file not exist or empty, creating init.file"
    /opt/vault/vault operator init -key-shares=1 -key-threshold=1 | tee /etc/vault/init.file
else
   echo "vault init.file exist and not empty"
fi

echo 'export root token to env var'
export VAULT_TOKEN=$(egrep -m5 '^Initial Root Token' /etc/vault/init.file | cut -f2- -d: | tr -d ' ')

echo 'unseals the vault'
egrep -m3 '^Unseal Key' /etc/vault/init.file | cut -f2- -d: | tr -d ' ' | while read key; do   /opt/vault/vault operator unseal ${key}; done
