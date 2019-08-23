#!/bin/bash -x
sudo systemctl stop vault
sudo /usr/sbin/userdel vault
REDHAT_VAULT_SRV='/usr/lib/systemd/system/vault.service'
REDHAT_VAULT_SRV_OVERRIDE='/etc/systemd/system/vault.service.d/'
DEBIAN_VAULT_SRV='/lib/systemd/system/vault.service'
INSTALL_PATH='/opt/vault'

if [ -f $REDHAT_VAULT_SRV ]; then
   sudo rm -rf $REDHAT_VAULT_SRV $INSTALL_PATH $REDHAT_VAULT_SRV_OVERRIDE
   sudo systemctl daemon-reload
elif [ $DEBIAN_VAULT_SRV ]; then
   rm -rf $DEBIAN_VAULT_SRV $INSTALL_PATH
   systemctl daemon-reload
else
   echo 'vault.service does not exist'
fi

