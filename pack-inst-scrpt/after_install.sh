#!/bin/bash
cd /opt/vault/certs
./create_certificates.sh
cp -r  work/* /opt/vault
chmod -R 770 /opt/vault
chown -R vault:vault /opt/vault

if [ -d "/usr/lib/systemd/system/" ]
then
    cp /opt/vault/vault.service /usr/lib/systemd/system/vault.service
    mkdir -p /etc/systemd/system/vault.service.d
    echo [Service] > /etc/systemd/system/vault.service.d/override.conf
    chown vault:vault /etc/systemd/system/vault.service.d/override.conf
    chmod 770 /etc/systemd/system/vault.service.d/override.conf
    echo Environment=VAULT_ADDR='https://localhost:8200' >> /etc/systemd/system/vault.service.d/override.conf
    echo Environment=VAULT_CAPATH=/opt/vault/ca/certs/ca.cert.pem >> /etc/systemd/system/vault.service.d/override.conf
    systemctl daemon-reload
fi
