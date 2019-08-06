#!/bin/bash
export VAULT_ADDR='https://localhost:8200'

if [[ ! -f /etc/vault/init.file ]] ; then
    echo 'do one' 
    /opt/vault/vault operator init -key-shares=1 -key-threshold=1 | tee /etc/vault/init.file
    echo 'do three'
fi

echo 'export root token to env var'
export VAULT_TOKEN=$(egrep -m5 '^Initial Root Token' /etc/vault/init.file | cut -f2- -d: | tr -d ' ')

echo 'unseals the vault'
egrep -m3 '^Unseal Key' /etc/vault/init.file | cut -f2- -d: | tr -d ' ' | while read key; do   /opt/vault/vault operator unseal ${key}; done
