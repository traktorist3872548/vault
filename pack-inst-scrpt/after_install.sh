
#!/bin/bash -x
export VAULT_ADDR='http://127.0.0.1:8200'
nohup /opt/vault/vault server -dev -config=/opt/vault/vault.hcl &
export VAULT_TOKEN=0000-0000-0000-0000
sleep 2
/opt/vault/setup_vault_data.sh
pkill vault
