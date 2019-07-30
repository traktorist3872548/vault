cd ~/vault-deploy
systemctl stop vault
rm -f /etc/systemd/system/vault.service
systemctl daemon-reload
rm -rf /etc/vault/
rm -rf /opt/vault/
userdel vault
