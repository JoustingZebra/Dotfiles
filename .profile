# This script is a welcome message to integrate into .profile
function welcome_message(){

local BOLD=$(tput bold)
local ROMAN=$(tput sgr0)
local arch=$(uname -mpi)
local cpu=$(cat /proc/cpuinfo | grep "model name" | sort -u | cut -d : -f2 | xargs)
local currentshell=$(ps $$ | awk 'NR==2{print$5}' | sed -s 's/\/bin\///g')
local date=$(date -I)
local groups=$(groups)
local hostname=$(hostname)
local ip_addr=$(hostname -I)
local os=$(awk -F '"' '/PRETTY/ {print $2}' /etc/os-release | tr -d '\n')
local os_version=$(awk -F '"' '/VERSION/ {print $2}' /etc/os-release | head -n 1)
local packages=$(dpkg --get-selections | wc -l)
local ram=$(free --si -h | awk '/Mem/{print $3" / "$2}')
local time=$(date "+%R")
local tty=$(tty)
local upsec=$(awk '{print $1}' /proc/uptime)
local upsec=${upsec%\.*}
local whoami=$(whoami)

printf "\n"
echo "${BOLD}$date $time"
echo "Welcome to $hostname, $whoami!"
printf "\n"
echo -n "Host: ${ROMAN} $os $os_version	${BOLD}IP:${ROMAN} $ip_addr	"       

if [[ -e /proc/uptime ]] ; then
	echo -n "${BOLD}Uptime: ${ROMAN}"
	printf '%d days, %d hours, %d minutes \n' $(($upsec%604800/86400)) $(($upsec%86400/3600)) $(($upsec%3600/60))
else
	echo "Uptime not found"
fi

echo "${BOLD}CPU:${ROMAN} $cpu	${BOLD}RAM (Used/Total):${ROMAN} $ram	${BOLD}Architecture:${ROMAN} $arch 	"
echo "${BOLD}Groups:${ROMAN} $groups    ${BOLD}Current shell:${ROMAN} $currentshell     ${BOLD}TTY:${ROMAN} $tty"
echo "${BOLD}Packages:${ROMAN} $packages"
printf "\n"
echo "${BOLD}Available shells:${ROMAN}"
sed -s 's/\/bin\///g' /etc/shells | sed -s 's/\/usr//g' | grep -v "valid login" | sort -u

# if bash is the current shell && .bashrc is in the home directory, source it.
if [[ $currentshell == *"bash" ]];then
	if [ -f ~/.bashrc ]; then
		source ~/.bashrc
	fi
fi
}

welcome_message
