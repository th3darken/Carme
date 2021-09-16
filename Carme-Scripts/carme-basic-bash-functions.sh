#!/bin/bash
#-----------------------------------------------------------------------------------------------------------------------------------
# basic bash functions needed in CARME
#-----------------------------------------------------------------------------------------------------------------------------------


# check if config is available -----------------------------------------------------------------------------------------------------
CLUSTER_DIR="/opt/Carme"
CONFIG_FILE="CarmeConfig"

if [[ ! -f ${CLUSTER_DIR}/${CONFIG_FILE} ]];then
  echo "ERROR: no config-file found in ${CLUSTER_DIR}"
  exit 200
fi
#-----------------------------------------------------------------------------------------------------------------------------------



# definitions of basic bash functions

# check if bash is used to execute the script --------------------------------------------------------------------------------------
# USAGE: is_bash
function is_bash () {
  if [[ ! "$BASH_VERSION" ]]; then
    echo "ERROR: This is a bash-script. Please use bash to execute it!"
    exit 200
  fi
}
#-----------------------------------------------------------------------------------------------------------------------------------


# check if root executes this script -----------------------------------------------------------------------------------------------
# USAGE: is_root
function is_root () {
  if [[ ! "$(whoami)" = "root" ]]; then
    echo "ERROR: you need root privileges to run this script"
    exit 200
  fi
}
#-----------------------------------------------------------------------------------------------------------------------------------


# get_variable function ------------------------------------------------------------------------------------------------------------
# USAGE: get_variable CARME_VARIABLE
function get_variable () {
  variable_value=$(grep --color=never -Po "^${1}=\K.*" "${CLUSTER_DIR}/${CONFIG_FILE}")
  variable_value=$(echo "${variable_value}" | tr -d '"')
  echo "${variable_value}"
}
#-----------------------------------------------------------------------------------------------------------------------------------


# define function that checks if a command is available or not ---------------------------------------------------------------------
function check_command () {
  if ! command -v "${1}" >/dev/null 2>&1 ;then
    echo "ERROR: command '${1}' not found"
    exit 200
  fi
}
#-----------------------------------------------------------------------------------------------------------------------------------
