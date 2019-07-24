#!/bin/bash/

#create a vault system user
#/var/lib/vault  will be used as the Vault data directory to store encrypted secrets on the local filesystem

useradd -r -d /var/lib/vault -s /bin/nologin vault

#Set the ownership of /var/lib/vault to the vault user and the vault group

install -o vault -g vault -m 750 -d /var/lib/vault



