#!/bin/bash
echo "create certificates"
sh ./create_certificates.sh
echo "install vault as service"
sh ./install_vault.sh
#echo "vault initializing"
#sh ./init.sh
systemctl enable vault
systemctl start vault
systemctl status vault
/opt/vault/vault status
