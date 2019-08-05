#!/bin/bash
/opt/vault/vault operator init -key-shares=1 -key-threshold=1 | tee /etc/vault/init.file
