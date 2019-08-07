cd ~/vault-deploy
systemctl stop vault
rm -f /usr/lib/systemd/system/vault.service
systemctl daemon-reload
rm -rf /etc/vault/
rm -rf /opt/vault/
userdel vault

rm -rf download
rm -rf vault
rm -rf work
