
#!/bin/bash -x
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=0000-0000-0000-0000
chown -R vault:vault /opt/vault
chmod -R 750 /opt/vault
