#!/bin/bash

#export vars
export VAULT_ADDR='https://localhost:8200'
/opt/vault/vault operator init -key-shares=1 -key-threshold=1
