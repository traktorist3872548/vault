#!/bin/bash -x
systemctl stop vault
/usr/sbin/userdel vault
rm -rf /usr/lib/systemd/system/vault.service
rm -fr /etc/systemd/system/vault.service.d
rm -rf /opt/vault

