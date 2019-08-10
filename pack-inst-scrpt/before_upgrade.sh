!/bin/bash
echo $(systemctl is-active vault) > /tmp/status.vault
systemctl stop vault
