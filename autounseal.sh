#!/bin/bash
export VAULT_ADDR='https://localhost:8200'
export VAULT_CAPATH=/opt/vault/ca/certs/ca.cert.pem

#export root token to env var
export VAULT_TOKEN=$(egrep -m5 '^Initial Root Token' /etc/vault/init.file | cut -f2- -d: | tr -d ' ')

#unseals the vault:
egrep -m3 '^Unseal Key' /etc/vault/init.file | cut -f2- -d: | tr -d ' ' | while read key; do   /opt/vault/vault operator unseal ${key}; done
