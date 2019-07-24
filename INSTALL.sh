#!/bin/bash
echo "create certificates"
sh ./create_certificates.sh
echo "install vault as service"
sh ./install_vault.sh
echo "add unit for systemd"
sh ./create_vault_systemd_unit.sh
