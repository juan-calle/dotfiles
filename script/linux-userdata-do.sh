#!/usr/bin/env bash
### ------------- User data script for quick web server setup ------------- ###
# https://www.digitalocean.com/docs/droplets/tutorials/recommended-setup/
# https://www.digitalocean.com/docs/recommended-droplet-setup.sh

set -euo pipefail

USERNAME=${1:-"jc"} # Customize the sudo non-root username here

# Create user and immediately expire password to force a change on login
useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
passwd --delete "${USERNAME}"
chage --lastday 0 "${USERNAME}"

# Create SSH directory for sudo user and move keys over
HOME_DIR="$(eval echo ~"${USERNAME}")"
mkdir --parents "${HOME_DIR}/.ssh"
cp /root/.ssh/authorized_keys "${HOME_DIR}/.ssh"
chmod 0700 "${HOME_DIR}/.ssh"
chmod 0600 "${HOME_DIR}/.ssh/authorized_keys"
chown --recursive "${USERNAME}":"${USERNAME}" "${HOME_DIR}/.ssh"

# Disable root SSH login with password
sed --in-place \
  's/^PermitRootLogin.*/PermitRootLogin prohibit-password/g' \
  /etc/ssh/sshd_config
if sshd -t -q; then systemctl restart sshd; fi
