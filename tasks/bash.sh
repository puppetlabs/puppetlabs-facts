#!/bin/bash

# This script may be called outside of a task, e.g. by puppet_agent
# so we have to just paste this code here.  *grumbles*
# Exit with an error message and error code, defaulting to 1
fail() {
  # Print a message: entry if there were anything printed to stderr
  if [[ -s $_tmp ]]; then
    # Hack to try and output valid json by replacing newlines with spaces.
    error_data="{ \"msg\": \"$(tr '\n' ' ' <"$_tmp")\", \"kind\": \"bash-error\", \"details\": {} }"
  else
    error_data="{ \"msg\": \"Task error\", \"kind\": \"bash-error\", \"details\": {} }"
  fi
  echo "{ \"status\": \"failure\", \"_error\": $error_data }"
  exit ${2:-1}
}

validation_error() {
  error_data="{ \"msg\": \""$1"\", \"kind\": \"bash-error\", \"details\": {} }"
  echo "{ \"status\": \"failure\", \"_error\": $error_data }"
  exit 255
}

success() {
  echo "$1"
  exit 0
}

# Get info from one of /etc/os-release or /usr/lib/os-release
# This is the preferred method and is checked first
_systemd() {
  # These files may have unquoted spaces in the "pretty" fields even if the spec says otherwise
  source <(sed 's/ /_/g' "$1")

  if [[ ${ID_LIKE,,} =~ 'debian' ]]; then
    family='Debian'
  elif [[ ${ID_LIKE,,} =~ 'rhel' ]]; then
    family='RedHat'
  else
    family="${ID^}"
  fi
}

# Get info from lsb_release
_lsb_release() {
  read -r ID < <(lsb_release -is)
  read -r VERSION_ID < <(lsb_release -rs)
}

# Get info from rhel /etc/*-release files
_rhel() {
  family='RedHat'
  # slurp the file
  ver_info=$(<"$1")
  # ID is the first word in the string
  ID="${ver_info%% *}"

  # Get a string like 'release 1.2.3' and grab everything after the space
  release=$(grep -Eo 'release[[:space:]]*[0-9.]+' "$1")
  VERSION_ID="${release#* }"
}

# Last resort
_uname() {
  ID="$(uname)"
  full="$(uname -r)"
}

munge_name() {
  if [[ ${!osmap[@]} =~ "${1,,}" ]]; then
    echo "${osmap[${1,,}]}"
  else
    echo "${1^}"
  fi
}

_tmp="$(mktemp)"
exec 2>>"$_tmp"

# Use indirection to munge PT_ environment variables
# e.g. "$PT_version" becomes "$version"
for v in ${!PT_*}; do
  declare "${v#*PT_}"="${!v}"
done

# Set up an error trap and let any functions inhert it
trap 'fail "Error getting system information"' ERR
set -E

# Taken from https://github.com/puppetlabs/facter/blob/master/lib/inc/facter/facts/os.hpp
# If not in this list, we just uppercase the first character
declare -A osmap=([redhat]=RedHat [rhel]=RedHat [centos]=CentOS [cloud]=CloudLinux [virtuozzo]=VirtuozzoLinux [psbm]=PSBM [ol]=OracleLinux [ovl]=OSV [oel]=OEL [xenserver]=XenServer [linuxmint]=LinuxMint [sles]=SLES [suse]=SuSE [opensuse]=OpenSuSE [sunos]=SunOS [omni]=OmniOS [openindiana]=OpenIndiana [manjaro]=ManjaroLinux [smart]=SmartOS [openwrt]=OpenWrt [meego]=MeeGo [coreos]=CoreOS [zen]=XCP [kfreebsd]='GNU/kFreeBSD' [arista]=AristaEOS [huawei]=HuaweiOS [photon]=PhotonOS)

if [[ -e /etc/os-release ]]; then
  _systemd /etc/os-release
elif [[ -e /usr/lib/os-release ]]; then
  _systemd /usr/lib/os-release
fi

# If either systemd is not installed or we didn't get a minor version from os-release
if (( ${VERSION_ID%%.*} == ${VERSION_ID#*.} )); then
  if [[ -e /etc/fedora-release ]]; then
    _rhel /etc/fedora-release
  elif [[ -e /etc/centos-release ]]; then
    _rhel /etc/centos-release
  elif [[ -e /etc/redhat-release ]]; then
    _rhel /etc/redhat-release
  elif type lsb_release &>/dev/null; then
    _lsb_release
  else
    _uname
  fi
fi

full="${VERSION_ID}"
major="${VERSION_ID%%.*}"
# Minor is considered the second part of the version string
IFS='.' read -ra minor <<<"$full"
minor="${minor[1]}"

ID="$(munge_name "$ID")"
family="$(munge_name "$family")"

# We should change puppet_agent to not work this way
if [[ $@ =~ 'platform' ]]; then
  success "$ID"
elif [[ $@ =~ 'release' ]]; then
  success "$full"
fi

success "$(cat <<EOF
{
  "os": {
    "name": "${ID}",
    "release": {
      "full": "$full",
      "major": "$major",
      "minor": "$minor"
    },
    "family": "${family}"
  }
}
EOF
)"
