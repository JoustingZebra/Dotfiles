#!/bin/bash

# This is a script to init a new system

sudo echo "L33tM3"

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

cd ~

# Upgrade system
# apt upgrade is potentially unsafe on rolling distros.
echo -e "/n"
echo -n "Update? (y/n)>"
read userinput
if [[ $userinput == y* ]]; then
    apt update && apt full-upgrade
    sudo apt-get install -f
    apt update && apt full-upgrade
    apt-get autoclean
    apt-get autoremove
    dpkg --configure -a
    
    if [[ -n $(cat /etc/os-release | grep parrot) ]]; then

      parrot-upgrade
      apt-get autoclean
      apt-get autoremove
      dpkg --configure -a
    fi
else
  echo "Skipping system update"
fi

# Put kali repos in parrot and vise versa

echo -n "Add Parrot OS rolling security repo or metapackage? (y/n)>"
read userinput
if [[ $userinput == y* ]]; then
    # if not Parrot OS and parrot repos not present
    if [[ -z $(cat /etc/os-release | grep parrot) && -z $(cat /etc/apt/sources.list | grep parrot.sh)  ]]; then
    echo "Adding Parrot OS Repos"
    echo "deb https://deb.parrot.sh/parrot/ rolling main contrib non-free" > /etc/apt/sources.list
    echo "deb https://deb.parrot.sh/parrot/ rolling-security main contrib non-free" > /etc/apt/sources.list
    wget -q -O - https://deb.parrotsec.org/parrot/misc/parrotsec.gpg | sudo gpg --import
    gpg --keyserver keyserver.ubuntu.com --recv-keys 363A96A5CEA9EA27
    apt update
    else
    echo -e "\n"
    echo "Parrot OS repos present, no repos to import"
    fi

    echo -n "Do you want to add AnonSurf? (y/n)>"
    read userinput
    if [[ $userinput == y* ]]; then
        apt install anonsurf-gtk
        dpkg --configure -a
        apt --fix-broken install
    fi
     
    install_package=1
    
    while [ $install_package == 1 ]; do
        echo -n "Install a Parrot OS metapackage? (y/n)>"
        read userinput
        if [[ $userinput == y* ]]; then
          # install metapackages
          if [ $install_package == 1 ]; then
            echo  "1. parrot-core - Core package for Parrot OS"
            echo  "2. parrot-crypto - Parrot Encryption Tools"
            echo  "3. parrot-devel - Parrot Development Tools (IDEs & utilities)"
            echo  "4. parrot-devel-tools - Parrot Development tools (compilers & tools)"
            echo  "5. parrot-drivers - Parrot drivers metapackage."
            echo  "6. parrot-tools - Penetration testing and security auditing distribution (Everything)"
            echo  "7. parrot-tools-automotive - Pentest tools for vehicle hacking"
            echo  "8. parrot-tools-cloud - Pentest tools for cloud environments"
            echo  "9. parrot-tools-forensics - Pentest tools for forensics"
            echo  "10. parrot-tools-full - Metapackage that installs a full penetration testing environment"
            echo  "11. parrot-tools-infogathering - Pentest tools for information gathering"
            echo  "12. parrot-tools-maintain - Pentest tools for maintaining access"
            echo  "13. parrot-tools-password - Pentest tools for password attack"
            echo  "14. parrot-tools-postexploit - Pentest tools for post exploitation"
            echo  "15. parrot-tools-pwn - Pentest tools for exploitation"
            echo  "16. parrot-tools-reporting - Pentest tools for reporting"
            echo  "17. parrot-tools-reversing - Pentest tools for reverse engineering"
            echo  "18. parrot-tools-sniff - Pentest tools for network sniffing"
            echo  "19. parrot-tools-vuln - Pentest tools for vulnerability analysis"
            echo  "20. parrot-tools-web - Pentest tools for web analysis"
            echo  "21. parrot-tools-wireless - Pentest tools for wireless exploitation"
            echo  "22. parrot-meta-sdr - Parrot Security SDR tools"
            echo  "23. parrot-privacy - Parrot Privacy Protection Tools"
            echo  "24. parrot-zsh-profiles - Parrot ZSH configuration"

            echo -n "Select metapackages(1-29)>"
            read meta_selection
            echo "Installing package: $meta_selction"
            case $meta_selection in
                  ## System / Other
                  1)
                    apt install parrot-core
                    ;;
                  2)
                    apt install parrot-crypto
                    ;;
                  3)
                    apt install parrot-devel
                    ;;
                  4)
                    apt install parrot-devel-tools
                    ;;
                  5)
                    apt install parrot-drivers
                    ;;
                  6)
                    apt install parrot-tools
                    ;;
                  7)
                    apt install parrot-tools-automotive
                    ;;
                  8)
                    apt install parrot-tools-cloud
                    ;;
                  9)
                    apt install parrot-tools-forensics
                    ;;
                  10)
                    apt install parrot-tools-full
                    ;;
                  11)
                    apt install parrot-tools-infogathering
                    ;;
                  12)
                    apt install parrot-tools-maintain
                    ;;
                  13)
                    apt install parrot-tools-password
                    ;;
                  14)
                    apt install parrot-tools-postexploit
                    ;;
                  15)
                    apt install parrot-tools-pwn
                    ;;
                  16)
                    apt install parrot-tools-reporting
                    ;;
                  17)
                    apt install parrot-tools-reversing
                    ;;
                  18)
                    apt install parrot-tools-sniff
                    ;;
                  19)
                    apt install parrot-tools-vuln
                    ;;
                  20)
                    apt install parrot-tools-web
                    ;;
                  21)
                    apt install parrot-tools-wireless
                    ;;
                  22)
                    apt install parrot-meta-sdr
                    ;;
                  23)
                    apt install parrot-privacy
                    ;;
                  24)
                    apt install parrot-zsh-profiles
                    ;;
                  *)
                    echo "invalid selection"
                    ;;
            esac
        fi
        else
          install_package=0
          echo "Skiping Parrot OS rolling security repo"
        fi
    done
fi

echo -e "/n"
echo -n "Add Kali Linux rolling security repo or metapackage? (y/n)>"
read userinput

if [[ $userinput == y* ]]; then
    # if parrot OS and no Kali repos
    if [[ -n $(cat /etc/os-release | grep parrot) && -z $(cat /etc/apt/sources.list.d/parrot.list | grep kali.org) ]]; then
        echo "Adding Kali Linix Repos"
        echo "deb https://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list.d/parrot.list
        echo "#deb-src http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list.d/parrot.list
        wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc
        apt update
    
    else
        #if not Kali-Linux and not Parrot OS and no Kali repos
        if [[ -z $(cat /etc/os-release | grep Kali) && -z $(cat /etc/os-release | grep parrot) && -z $(cat /etc/apt/sources.list | grep kali.org) ]]; then
          echo "Adding Kali Linux Repos"
          echo "deb https://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list
          echo "#deb-src http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list
          wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc
          apt update
        # elif is Kali
        elif [[ -n $(cat /etc/os-release | grep Kali) ]]; then
          echo "Kali Linux repos present, no repos to import"
        fi
    fi
    
    
    echo -n "Do you want to install kali-undercover? (y/n)>"
    read userinput
        if [[ $userinput == y* ]]; then
        apt install kali-desktop-base
        apt install kali-desktop-core
        apt install kali-desktop-xfce
        apt install -f
        fi
       
       
    # if user wants kali metapackages
    install_package=1
    
    while [ $install_package == 1 ]; do
        echo -n "Install a Kali metapackage? (y/n)>"
        read userinput
        if [[ $userinput == y* ]]; then
        
        # install metapackages
          if [ $install_package == 1 ]; then
              echo "1. kali-linux-core # Base Kali Linux System - core items that are always included"
              echo "2. kali-linux-default # 'Default' desktop (amd64/i386) images include these tools"
              echo "3. kali-tools-top10 # The 10 most commonly used tools"
              echo "4. kali-tools-headless # All tools that have no GUI"
              echo "5. kali-linux-large # previous default tools for amd64/i386 images"
              echo "6. kali-linux-everything # Every metapackage and tool listed here (The motherload)" 
              echo "7. kali-tools-802-11 # 802.11 (Commonly known as 'Wi-Fi')"
              echo "8. kali-tools-bluetooth # For targeting Bluetooth devices"
              echo "9. kali-tools-crypto-stego # Tools based around Cryptography & Steganography" 
              echo "10. kali-tools-database # Based around any database attacks"
              echo "11. kali-tools-exploitation # Commonly used for doing exploitation (armitage, beef-xss, MSF,etc)"
              echo "12. kali-tools-forensics # Forensic tools - Live & Offline" 
              echo "13. kali-tools-fuzzing # For fuzzing protocols"
              echo "14. kali-tools-gpu # Tools which benefit from having access to GPU hardware"
              echo "15. kali-tools-hardware # Hardware hacking tools" 
              echo "16. kali-tools-information-gathering # Used for OSINT & information gathering"
              echo "17. kali-tools-passwords # Helpful for password cracking attacks - Online & offline"
              echo "18. kali-tools-post-exploitation # Techniques for post exploitation stage" 
              echo "19. kali-tools-reporting # Reporting tools"
              echo "20. kali-tools-reverse-engineering # For reverse engineering binaries"
              echo "21. kali-tools-rfid # Radio-Frequency IDentification tools"
              echo "22. kali-tools-sdr # Software-Defined Radio tools" 
              echo "23. kali-tools-sniffing-spoofing # Any tools meant for sniffing & spoofing"
              echo "24. kali-tools-social-engineering # Aimed for doing social engineering techniques"
              echo "25. kali-tools-voip # Voice over IP tools"
              echo "26. kali-tools-vulnerability # Vulnerability assessments tools" 
              echo "27. kali-tools-web # Designed doing web applications attacks"
              echo "28. kali-tools-windows-resources # Any resources which can be executed on a Windows hosts"
              echo "29. kali-tools-wireless # All tools based around Wireless protocols - 802.11, Bluetooth, RFID & SDR"

              echo -n "Select metapackages(1-29)>"
              read meta_selection
              echo "Installing package: $meta_selction"

              case $meta_selection in
                ## System / Other
                1)
                  apt-get install kali-linux-core
                  ;;
                2)
                  apt-get install kali-linux-default
                  ;;
                3)
                  apt-get install kali-tools-top10
                  ;;
                4)
                  apt-get install kali-tools-headless
                  ;;
                5)
                  apt-get install kali-linux-large
                  ;;
                6)
                  apt-get install kali-linux-everthing
                  ;;
                ## Tools
                7)
                  apt-get install kali-tools-802-11
                  ;;
                8)
                  apt-get install kali-tools-bluetooth
                  ;;
                9)
                  apt-get install kali-tools-crypto-stego
                  ;;
                10)
                  apt-get install kali-tools-database
                  ;;
                11)
                  apt-get install kali-tools-exploitation
                  ;;
                12)
                  apt-get install kali-tools-forensics
                  ;;
                13)
                  apt-get install kali-tools-fuzzing
                  ;;
                14)
                  apt-get isntall kali-tools-gpu
                  ;;
                15)
                  apt-get install kali-tools-hardware
                  ;;
                16)
                  apt-get install kali-tools-information-gathering
                  ;;
                17)
                  apt-get kali-tools-passwords
                  ;;
                18)
                  apt-get install kali-tools-post-exploitation
                  ;;
                19)
                  apt-get install kali-tools-reporting
                  ;;
                20)
                  apt-get install kali-tools-reverse-engineering
                  ;;
                21)
                  apt-get install kali-tools-rfid
                  ;;
                22)
                  apt-get install kali-tools-sdr
                  ;;
                23)
                  apt-get install kali-tools-sniffing-spoofing
                  ;;
                24) 
                  apt-get install kali-tools-social-engineering
                  ;;
                25)
                  apt-get install kali-tools-voip
                  ;;
                26)
                  apt-get install kali-tools-vulnerability
                  ;;
                27)
                  apt-get install kali-tools-web
                  ;;
                28)
                  apt-get install kali-tools-windows-resources
                  ;;
                29)
                  apt-get install  kali-tools-wireless
                  ;;
                *)
                  echo "invalid selection"
                  ;;
              esac
          fi
          else
          install_package=0
          echo -e "/n"
          echo "Skipping Kali Linux rolling security repo"
          fi
      done
fi
echo -e "/n"
echo -n "Update? (y/n)>"
read userinput
if [[ $userinput == y* ]]; then
    apt update && apt full-upgrade
    apt-get autoremove
else
    echo "Skipping system update"
fi


# prompt user for config file load
echo -e "/n"
echo -n "Do you wish to load dotfiles? (y/n)>"
read userinput
if [[ $userinput == y* ]]; then
    #backup
    mv .bashrc .bashrc.bak
    mv .vimrc .vimrc.bak
    mv .profile .profile.bak
    
    curl -o .bashrc https://raw.githubusercontent.com/JoustingZebra/Dotfiles/main/.bashrc
    curl -o .profile https://raw.githubusercontent.com/JoustingZebra/Dotfiles/main/.profile
    curl -o .sshrc https://raw.githubusercontent.com/JoustingZebra/Dotfiles/main/.sshrc
    curl -o .vimrc https://raw.githubusercontent.com/JoustingZebra/Dotfiles/main/.vimrc
    curl -o .zshrc https://raw.githubusercontent.com/JoustingZebra/Dotfiles/main/.zshrc
    source .bashrc
else
    echo "Skipping dotfile load"
fi


# if has desktop 
if [[ -n $(echo $XDG_CURRENT_DESKTOP) ]]; then
echo "testing"
# RICE THINGS https://www.reddit.com/r/unixporn/ 
fi


# Pull tools
# prompt user for config file load
echo -e "/n"
echo -n "Do you wish to install standard tools? (y/n)>"
read userinput
if [[ $userinput == y* ]]; then

    # 0trace
    apt-get install 0trace

    # cewl
    apt-get install cewl

    #chntpw
    apt-get install chntpw

    # crunch
    apt-get install crunch

    # ftp
    apt-get install ftp

    # git
    apt-get install git

    # gpg
    apt-get install gpg

    #hashid
    apt-get install hashid

    #hash-identifier
    apt-get install hash-identifier

    # impacket
    apt-get install python3-impacket

    # Searchsploit / ExploitDB
    apt-get install exploitdb

    # Python3 
    apt-get install python3
    apt-get install pip

    # SSHRC
    wget https://raw.githubusercontent.com/taylorskalyo/sshrc/master/sshrc
    chmod 700 sshrc
    mv sshrc /usr/local/bin #or anywhere else on your PATH

    # Nmap
    apt-get install nmap

    # man
    apt-get install man

    # shellcheck
    apt-get install shellcheck

    # Tmux
    apt-get install tmux

    # TOR
    apt-get install tor

    # GCC && GDB
    apt-get install gcc
    apt-get install gdb

    # Pentest framework
    git clone https://github.com/trustedsec/ptf.git
    cd ptf
    pip install -r requirements.txt

    ## These should be managed with ptf
    # Turbolist3r
    # twint?

    # proxychains
    ## try to have an auto-configure script for this
    apt-get install proxychains4

    # Powershell
    apt-get install powershell

    #pwncat
    apt-get install pwncat

    # Tracers
    apt-get install strace
    apt-get install ltrace

    # wordlists
    apt-get install wordlists
else
    echo "Skipping tool install"
fi

## install OSG repos
