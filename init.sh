#!/bin/bash
export VAULT_ADDR='https://localhost:8200'
export VAULT_CAPATH=/opt/vault/ca/certs/ca.cert.pem
/opt/vault/vault operator init -key-shares=1 -key-threshold=1 | tee /etc/vault/init.file
