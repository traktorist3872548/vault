#!/bin/bash/
echo "create certificates"
create_certificates.sh
echo "install vault as service"
install_vault.sh
echo "add unit for systemd"
create_vault_systemd_unit.sh
