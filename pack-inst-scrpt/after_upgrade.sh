#!/bin/bash
if [ -d "/usr/lib/systemd/system/" ]
then
    cp /opt/tagml/vault.service /usr/lib/systemd/system/vault.service
else
    cp /opt/vault/vault.service /lib/systemd/system/vault.service
fi
systemctl daemon-reload

if grep -q -w 'active' /tmp/status.vault
then
    rm -rf /tmp/status.vault
    systemctl start vault
fi
