#!/bin/bash
grep "vault:" /etc/passwd >/dev/null
if [ $? -ne 0 ]; then
   useradd -r -d /opt/vault/keystore -s /bin/nologin vault
   #Set the ownership of /opt/vault/keystore to the vault user and the vault group
   install -o vault -g vault -m 750 -d /opt/vault/keystore
fi
