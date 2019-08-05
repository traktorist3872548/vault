#!/bin/bash
echo "create certificates"
sh ./create_certificates.sh
echo "install vault as service"
sh ./install_vault.sh
