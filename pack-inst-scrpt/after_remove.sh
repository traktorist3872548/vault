#!/bin/bash
systemctl stop vault
/usr/sbin/userdel vault
REDHAT_VAULT_SRV='/usr/lib/systemd/system/vault.service'
#DEBIAN_VAULT_SRV='/lib/systemd/system/vault.service'
INSTALL_PATH='/opt/vault'
CONFIG_PATH='/etc/vault'

if [ -f $REDHAT_VAULT_SRV ]; then
   rm -rf $REDHAT_VAULT_SRV $INSTALL_PATH $CONFIG_PATH
   systemctl daemon-reload
elif [ $DEBIAN_VAULT_SRV ]; then
   rm -rf $DEBIAN_VAULT_SRV $INSTALL_PATH $CONFIG_PATH
   systemctl daemon-reload
else
   echo 'vault.service does not exist'
fi

