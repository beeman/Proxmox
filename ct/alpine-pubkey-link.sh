#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/beeman/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/beeman/Proxmox/raw/main/LICENSE


function header_info {
clear
cat <<"EOF"

 *********************************
************************************
************************************
************++++==++****************
*********+.    .      .=************           @@@@@@@@                     @@@@             @@        @
*********+   :*****-.   .***********         @@@@@@@@@@@@                   @@@@            @@@@     @@@@
*********+   :*******=   -**********         @@@@     @@@@   @@@      @@@   @@@@ @@@@@      @@@@   @@@@@       @@@@@      @@       @@
*********+   :*******+ . :**********         @@@@      @@@@  @@@@     @@@   @@@@@@@@@@@@    @@@@ @@@@@       @@@@@@@@@@  @@@@     @@@@
*********+   :*******-   -**********         @@@@     @@@@   @@@@     @@@   @@@@     @@@@   @@@@@@@@       @@@@     @@@@  @@@@    @@@@
*********+   :++++=-.   :***********         @@@@@@@@@@@@@   @@@@     @@@   @@@@      @@@@  @@@@@@@@       @@@@@@@@@@@@@  @@@@   @@@@
*********+            .+************         @@@@@@@@@@      @@@@     @@@   @@@@      @@@@  @@@@ @@@@@     @@@@@@@@@@@@    @@@@  @@@@
*********+   :===++*****************         @@@@            @@@@     @@@   @@@@     @@@@@  @@@@   @@@@    @@@@             @@@@@@@@
*********+   :**********************         @@@@            @@@@@@@@@@@@   @@@@@@@@@@@@@   @@@@    @@@@@   @@@@@@@@@@@      @@@@@@
*********+.  :**********************          @@@              @@@@@@@@@      @@@@@@@@@     @@@@      @@@@    @@@@@@@@        @@@@
*********+. .:**********************                                                                                         @@@@
**********+==+**********************                                                                                       @@@@@
************************************                                                                                        @@
************************************
 *********************************

EOF
}
header_info
echo -e "Loading..."
APP="Alpine PubKey Link"
var_disk="8"
var_cpu="1"
var_ram="2048"
var_os="alpine"
var_version="3.19"
variables
color
catch_errors

function default_settings() {
  echo "I AM USING THE DEFAULT SETTINGS!"
  CT_TYPE="1"
  PW="-password pubkey"
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="yes"
  SSH_ROOT="yes"
  VERB="yes"
  echo_default
  echo "$SSH"
  echo "$SSH_ROOT"
}


function update_script() {
UPD=$(whiptail --backtitle "Proxmox VE Helper Scripts" --title "SUPPORT" --radiolist --cancel-button Exit-Script "Spacebar = Select" 11 58 1 \
  "1" "Check for Alpine Updates" ON \
  3>&1 1>&2 2>&3)

header_info
if [ "$UPD" == "1" ]; then
apk update && apk upgrade
exit;
fi
}

start
build_container
description

msg_ok "Completed Successfully!\n"
