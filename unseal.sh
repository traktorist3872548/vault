#!/bin/bash -x
export VAULT_ADDR='http://127.0.0.1:8200'
egrep -m3 '^Unseal Key' /opt/vault/init.file | cut -f2- -d: | tr -d ' ' | while read key; do   /opt/vault/vault operator unseal ${key}; done

