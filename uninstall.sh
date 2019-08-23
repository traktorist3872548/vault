systemctl stop vault
systemctl daemon-reload

rm -rf download
rm -rf vault
rm -rf build dist astra-vault-*.rpm
