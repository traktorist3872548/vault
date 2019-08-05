#!/bin/bash
# create installation folder
if [[ ! -d /opt/vault ]] ; then
    mkdir -p /opt/vault
fi

echo 'create a vault system user'
#/opt/vault/keystore  will be used as the Vault data directory to store encrypted secrets on the local filesystem

grep "vault:" /etc/passwd >/dev/null
if [ $? -ne 0 ]; then
   useradd -r -d /opt/vault/keystore -s /bin/nologin vault
   #Set the ownership of /opt/vault/keystore to the vault user and the vault group
   install -o vault -g vault -m 750 -d /opt/vault/keystore
fi

VAULT_VER="${VAULT_VER:-1.1.3}"
UNAME=$(uname -s |  tr '[:upper:]' '[:lower:]')
VAULT_ZIP="vault_${VAULT_VER}_${UNAME}_amd64.zip"
IGNORE_CERTS="${IGNORE_CERTS:-no}"
FQDN="$(hostname -f)"

# cleanup
mkdir -p vault
mkdir -p download

if [[ ! -f "download/${VAULT_ZIP}" ]] ; then
    cd download
    # install Vault
    if [[ "${IGNORE_CERTS}" == "no" ]] ; then
      echo "Downloading Vault with certs verification"
      wget "https://releases.hashicorp.com/vault/${VAULT_VER}/${VAULT_ZIP}"
    else
      echo "WARNING... Downloading Vault WITHOUT certs verification"
      wget "https://releases.hashicorp.com/vault/${VAULT_VER}/${VAULT_ZIP}" --no-check-certificate
    fi

    if [[ $? != 0 ]] ; then
      echo "Cannot download Vault"
      exit 1
    fi
    cd ..
fi

cd vault

if [[ -f vault ]] ; then
  rm vault
fi

unzip ../download/${VAULT_ZIP}
chmod a+x vault

# move binary to /opt/vault 
mv ./vault /opt/vault/

echo 'check vault installation'
/opt/vault/vault -h

cd ..
pwd
echo 'copy vault config file to /etc folder'
cp -r config/vault /etc/ 
echo 'copy certificates to /opt/vault/ca'
cp -r work/ca /opt/vault

echo 'set permissions'
chown vault:vault /etc/vault 
chmod 770 /etc/vault
chown -R vault:vault /opt/vault
chmod -R 770 /opt/vault 

echo copy systemd unit file to /etc/systemd/system
mv config/vault.service /etc/systemd/system/vault.service

