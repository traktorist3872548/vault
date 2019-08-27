#!/bin/bash -x

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN=00000000-0000-0000-0000-000000000000

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VAULT_BIN="/opt/vault/vault"


echo "###########################################################################"
echo "# Preparing policies                                                      #"
echo "###########################################################################"

${VAULT_BIN} policy write read-secret ${DIR}/read-secret-policy.conf

echo "###########################################################################"
echo "# Restoring non-versioned K/V backend at secret/                          #"
echo "###########################################################################"

${VAULT_BIN} secrets disable secret
${VAULT_BIN} secrets enable -path secret -version 1 kv

#echo "###########################################################################"
#echo "# Mounting versioned K/V backend at versioned/                            #"
#echo "###########################################################################"

#${VAULT_BIN} secrets enable -path versioned -version 2 kv

#echo "###########################################################################"
#echo "# Setup static AppId authentication                                       #"
#echo "###########################################################################"

#echo "vault auth enable app-id"
#${VAULT_BIN} auth enable app-id

#echo "vault write auth/app-id/map/app-id/my-spring-boot-app value=default display_name=spring-boot-app"
#${VAULT_BIN} write auth/app-id/map/app-id/my-spring-boot-app value=read-secret display_name=spring-boot-app

#echo "vault write auth/app-id/map/user-id/my-static-userid value=my-spring-boot-app"
#${VAULT_BIN} write auth/app-id/map/user-id/my-static-userid value=my-spring-boot-app

#nc -w 1 localhost 3306 > /dev/null


echo "###########################################################################"
echo "# Setup static PKI example                                                #"
echo "###########################################################################"

echo "vault secrets enable pki"
${VAULT_BIN} secrets enable pki

#echo "write pki/config/ca pem_bundle=-"
#cat intermediate.cert.pem intermediate.decrypted.key.pem | ${VAULT_BIN} write pki/config/ca pem_bundle=-

#echo "vault write pki/roles/localhost-ssl-demo allowed_domains=localhost,example.com allow_localhost=true max_ttl=72h"
#${VAULT_BIN} write pki/roles/localhost-ssl-demo allowed_domains=localhost,example.com allow_localhost=true max_ttl=72h

echo "###########################################################################"
echo "# Write test data to Vault                                                #"
echo "###########################################################################"

echo "vault kv put secret/my-spring-boot-app mykey=myvalue hello.world='Hello, World'"
${VAULT_BIN} kv put secret/my-spring-boot-app mykey=myvalue hello.world='Hello, World'

echo "vault kv put secret/kv/postgres vault.astra.sysop.username=sysop@io-tahoe.com vault.astra.sysop.password=ZK0JPUuny/pVq+ILOdxREg== vault.neo4j.user=neo4j vault.neo4j.password=neo4jneo4j vault.spring.datasource.username=edm vault.spring.datasource.password=edmedm"
${VAULT_BIN} kv put secret/kv/postgres vault.astra.sysop.username=sysop@io-tahoe.com vault.astra.sysop.password=ZK0JPUuny/pVq+ILOdxREg== vault.neo4j.user=neo4j vault.neo4j.password=neo4jneo4j vault.spring.datasource.username=edm vault.spring.datasource.password=edmedm

