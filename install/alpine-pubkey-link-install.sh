#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/beeman/Proxmox/raw/main/LICENSE
source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"

color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apk add newt
$STD apk add curl
$STD apk add openssh
$STD apk add nano
$STD apk add mc
$STD apk add pos
# Install postgres and redis server
$STD apk add postgresql postgresql-client redis
# Init postgres
$STD su - postgres -c "initdb -D /var/lib/postgresql/data"
$STD rc-service postgresql start
$STD rc-service redis start
# Init redis
$STD rc-update add postgresql
$STD rc-update add redis

msg_ok "Installed Dependencies"

motd_ssh
customize
