# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# English
export LC_ALL=en_US.UTF-8
export LANG=en_us.UTF-8
export LANGUAGE=en_us.UTF-8

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# turn on auto change directory
shopt -s  autocd

# promptvars, whatever those are.
shopt -s promptvars

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
## never have I been so offended by something that I 100% agree with

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
        
  # milliseconds since epoch
  function t_now {
     date +%s%3N
  }
  
  function t_start {
    t_start=${t_start:-$(t_now)}
    }
 
  function t_stop {
        local d_ms=$(($(t_now) - $t_start))
        local d_s=$((d_ms / 1000))
        local ms=$((d_ms % 1000))
        local s=$((d_s % 60))
        local m=$(((d_s / 60) % 60))
        local h=$((d_s / 3600))
        if ((h > 0)); then t_show=${h}h${m}m
            elif ((m > 0)); then t_show=${m}m${s}s
            elif ((s >= 10)); then t_show=${s}.$((ms / 100))s
            elif ((s > 0)); then t_show=${s}.$((ms / 10))s
            else t_show=${ms}ms
        fi
            unset t_start
        }
  
    function set_prompt () {
        t_stop
        }
  
        trap 't_start' DEBUG
        
        # define colors
        # for Bold colors change the 0 to a 1. I.e bold black is '\e[1;30m'

        reset_color=$'\033[0m'
        black=$'\033[0;30m'
        red=$'\033[0;31m'
        green=$'\033[0;32m'
        yellow=$'\033[0;33m'
        blue=$'\033[1;34m'
        purple=$'\033[0;35m'
        cyan=$'\033[0;36m'
        white=$'\033[0;37m'

        #High Intensity colors

        HI_black=$'\033[0;90m'
        HI_red=$'\033[0;91m'
        HI_green=$'\033[0;92m'
        HI_yellow=$'\033[0;93m'
        HI_blue=$'\033[0;94m'
        HI_purple=$'\033[0;95m'
        HI_cyan=$'\033[0;96m'
        HI_white=$'\033[0;97m'

        prompt_color=$reset_color
        info_color=$blue
        prompt_symbol=∈ # "belongs to" or "member of" symbol
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        prompt_color=$red
        info_color=$reset_color
        prompt_symbol=⊩ # forces symbol
    fi

        # This little line right here is a statement that gives us the prompt_status which is equal to "$?". i.e the exit code.
        # and calls t_stop
        PROMPT_COMMAND='t_stop; prompt_status="$?"; if [[ $prompt_status == "0" ]]; then prompt_status="0"; fi'
        # cooler prompt
        PS1='\[${prompt_color}\]${debian_chroot:+($debian_chroot)}(\[${info_color}\]\u${prompt_symbol}\h\[${prompt_color}\])-[\[$info_color\]\w\[${prompt_color}\]]-[\[$info_color\]$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed '"'"'s: ::g'"'"') files, $(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed '"'"'s/total //'"'"')\[${prompt_color}\]]\[\033[0m\]\n\[${prompt_color}\]\[${prompt_color}\][\[${info_color}${t_show}\[${prompt_color}\]]-(\[${info_color}\]$(echo $SHLVL)-${prompt_status}\[${prompt_color}\])\[${prompt_color}\]\$\[\033[0m\]'

        # BackTrack red prompt
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# backup prompts for prompt function
PS1_backup=$PS1
PS2_backup=$PS2

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lh'
alias la='ls -a'
alias l='ls -CF'

# yet more aliases
alias nano='nano -l'
alias cls='clear'
alias pfetch='clear && curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh'
alias powershell='pwsh'
alias py3='python3'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set environmental variables
export WORDLISTS="/usr/share/wordlists"

# command cheatsheet
cheat(){
    curl cheat.sh/"$1"
}

# search history with grep
ghist(){
   history | grep "$1";
}

# ping list of ip addresses in file (seperated by newline)
pinglist(){
    read -erp "Enter the file that contains the addresses you would like to ping:" Targets
    echo -e "\n"
    while read -r line; do
        local NoReply=$(ping "$line" -c 2 -q | grep "0 received")
        if [ "$NoReply" ]; then
            echo "No Reply from $line"
        else
            echo "Reply form $line"
        fi
        done < "$Targets"
}

# function that changes the prompt.
# not all machines may have a terminal capabile of supporting the default PS1, so it is now easy to change it on the fly
prompt(){
        if [ "$1" == "--classic" ]; then
                export PS1='\[\e[0m\]\u@\h\$'
        elif [ "$1" == "--custom" ]; then
                export PS1='\[\e[0;92m\]\u\[\e[0m\]@\[\e[0;92m\]\h\[\e[0m\][\[\e[0;92m\]\w\[\e[0m\]]\[[\[\e[0;92m\]$?\[\e[0m\]]\[\e[0m\]\$\[\e[0m\]'
        elif [ "$1" == "--custom2" ]; then
                export PS1='\[\e[0m\](\[\e[0;1m\]\u\[\e[0m\]@\[\e[0;1m\]\h\[\e[0m\])\[-(\[\e[0;1m\]\w \[\e[0m\][\[\e[0;1m\]$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed '"'"'s: ::g'"'"') files, $(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed '"'"'s/total //'"'"')\[\e[0m\]])\[\e[0m\]\$'
        elif [ "$1" == "--lean" ]; then
                export PS1='\[\e[0m\]\u\\$'
        elif [ "$1" == "--sh" ]; then
                export PS1="\\$ "
        elif [ "$1" == "--suse" ]; then
                export PS1="\u@\h:\w/ > "
                export PS2="> "
        elif [ "$1" == "--parrot" ]; then
                export PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
        elif [ "$1" == "--redhat" ]; then
                export PS1='[\u@\h \W]\$'
        elif [ "$1" == "--ubuntu" ]; then
                export PS1='\u@\h:\W\$'
        elif [ "$1" == "--zsh" ]; then
                export PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}('$info_color'\u${prompt_symbol}\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
        elif [ "$1" == "--reset" ]; then
                export PS1=$PS1_backup
                export PS2=$PS2_backup
        else
                echo "Error in prompt function"
        fi

}

# rot13
rot13(){
        if [ $# = 0 ] ; then
         tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]"
        else
         tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" < $1
    fi
}

# timecheck
timecheck(){
    local local_time=$(date -R)
    local UTC=$(date -uR)

    echo "UTC: $UTC"
    echo "local: $local_time"
}

# Weather report
weather(){
        if [ -n "$1" ]; then
            curl wttr.in/"$1"
        else
            curl wttr.in
        fi
}

export EDITOR=vim
# enable vi mode
set -o vi
