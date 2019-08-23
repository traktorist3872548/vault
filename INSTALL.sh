#!/bin/bash


#cleanup
rm -rf {build,dist,vault,download} || true

#create build folders
mkdir -p {build/opt/vault,build/usr/lib/systemd/system,dist,vault,download}

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
cp -r {vault/vault,vault.hcl,poststart.sh} ./build/opt/vault/
cp -r vault.service ./build/usr/lib/systemd/system/
#build rpm using fpm util
fpm -s dir -t rpm -n astra-vault -v 7.0 --config-files build/opt/vault/vault.hcl --before-install ./pack-inst-scrpt/before_install.sh --after-install ./pack-inst-scrpt/after_install.sh --after-remove ./pack-inst-scrpt/after_remove.sh --before-upgrade ./pack-inst-scrpt/before_upgrade.sh --after-upgrade ./pack-inst-scrpt/after_upgrade.sh --rpm-user vault --rpm-group vault --force ./build/=/
