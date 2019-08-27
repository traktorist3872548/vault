#!/bin/bash -x
sudo /usr/sbin/userdel vault
sudo rm -rf {/usr/lib/systemd/system/vault.service,/etc/systemd/system/vault.service.d,/opt/vault}

