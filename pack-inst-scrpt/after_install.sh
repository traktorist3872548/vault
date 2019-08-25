#!/bin/bash -x
export VAULT_ADDR='http://0.0.0.0:8200'
chmod -R 770 /opt/vault
chown -R vault:vault /opt/vault

if [ -d "/usr/lib/systemd/system/" ]
then
    mkdir -p /etc/systemd/system/vault.service.d
    echo [Service] > /etc/systemd/system/vault.service.d/override.conf
    chown vault:vault /etc/systemd/system/vault.service.d/override.conf
    chmod 770 /etc/systemd/system/vault.service.d/override.conf
    echo Environment=VAULT_ADDR='https://127.0.0.1:8200' >> /etc/systemd/system/vault.service.d/override.conf
    systemctl daemon-reload
fi
