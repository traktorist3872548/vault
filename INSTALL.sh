#!/bin/bash
#------------------------------- THAT WAS FIRST EXAMPLE OF BUILD-----------------------------
#echo "create certificates"
#sh ./create_certificates.sh
#echo "install vault as service"
#sh ./install_vault.sh
#echo "vault initializing"
#sh ./init.sh
#systemctl enable vault
#systemctl start vault
#systemctl status vault
#/opt/vault/vault status

#----------------------------- THE SCRIPT WHICH WILL BE CONVERTED TO JENKINSJOB--------------

#stage ('Checkout/Prebuild')
#git clone https://github.com/traktorist3872548/vault.git
cd vault

#cleanup
rm -rf {build,dist,vault,download} || true

#create build folders
mkdir -p {build/opt/vault,build/etc/vault,dist,vault,download}

#install vault to build dest folder
VAULT_VER="${VAULT_VER:-1.1.3}"
UNAME=$(uname -s |  tr '[:upper:]' '[:lower:]')
VAULT_ZIP="vault_${VAULT_VER}_${UNAME}_amd64.zip"
IGNORE_CERTS="${IGNORE_CERTS:-no}"

cd download
# install Vault
    if [[ "${IGNORE_CERTS}" == "no" ]] ; then
      echo "Downloading Vault with certs verification"
      curl https://releases.hashicorp.com/vault/${VAULT_VER}/${VAULT_ZIP} -o ${VAULT_ZIP}
    else
      echo "Downloading Vault WITHOUT certs verification"
      curl -k https://releases.hashicorp.com/vault/${VAULT_VER}/${VAULT_ZIP} -o ${VAULT_ZIP}
    fi

cd ../vault
unzip ../download/${VAULT_ZIP}
chmod a+x vault
cd ..
mv vault/vault build/opt/vault
cp -r ./poststart.sh build/opt/vault
cp -r config/vault build/etc/

#create certificates shold do after_install script
