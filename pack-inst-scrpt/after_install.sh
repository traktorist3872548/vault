#!/bin/bash -x
export VAULT_ADDR='http://0.0.0.0:8200'
chmod -R 770 /opt/vault
chown -R vault:vault /opt/vault
mkdir -p /etc/systemd/system/vault.service.d
echo [Service] > /etc/systemd/system/vault.service.d/override.conf
chown vault:vault /etc/systemd/system/vault.service.d/override.conf
chmod 770 /etc/systemd/system/vault.service.d/override.conf
echo Environment=VAULT_ADDR='http://0.0.0.0:8200' >> /etc/systemd/system/vault.service.d/override.conf
nohup /opt/vault/vault server -config=/opt/vault/vault.hcl &
/opt/vault/vault operator init -key-shares=1 -key-threshold=1 | tee /opt/vault/init.file
export VAULT_TOKEN=$(egrep -m5 '^Initial Root Token' /opt/vault/init.file | cut -f2- -d: | tr -d ' ')
echo Environment=VAULT_TOKEN=${VAULT_TOKEN} >> /etc/systemd/system/vault.service.d/override.conf
chmod -R 770 /opt/vault
chown -R vault:vault /opt/vault
systemctl daemon-reload
