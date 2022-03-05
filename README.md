# Dotfiles
A personal collection of configuration files

## So, what are these files?

## ~.bashrc
Run configuration for BASH. (The individual per-interactive-shell BASH startup file)

From the BASH man page:
> When an interactive shell that is not a login shell is started, bash reads and executes commands from ~/.bashrc, if that file exists.  This may be inhibited by using the --norc option.  The --rcfile file option will force bash to read and execute commands from file instead of ~/.bashrc.

### Includes:

- A variety of custom prompts
- Colored command outputs where possible ( ls, diff, dir, gcc, grep, ip, man, etc)
- Enable color prompt if available
- Many useful aliases
- Useful functions including:
  - cheat (auto curls cheat.sh)
  - ghist (greps bash history)
  - prompt (changes prompt on the fly)
  - rot13 (rotate by 13 places)
  - timecheck (prints UTC and local time)
  - weather (auto curls wttr.in) 
- Sets BASH to english UTF-8.
- Sets the shell to vi mode
- Varibles for prompt colors, makeing different color prompts painless
                             
## ~.zshrc
The same as .bashrc but for ZSH 
## ~.sshrc
Run configuration for [SSHRC](https://github.com/taylorskalyo/sshrc).
Bring your config files with you. 
This program will autoforward your config files when you ssh into another machine. Instead of ``` ssh 192.168.0.1``` use ```sshrc 192.168.0.1``` to invoke sshrc.

## ~.vimrc
Run configuration for [VIM](https://www.vim.org/).

### Includes:
- 1 tab = 4 spaces
- Highlights matching parenthesis/brackets.
- Line numbers
- Syntax highlighting
- No more overzelous backups
- UTF-8

## ~.profile
Upon logging in, the user will be greeted with a lightweight fetch written in pure shell

From the BASH man page:
> When bash is invoked as an interactive login shell, or as a non-interactive shell with the --login option, it first reads and executes commands from the file /etc/profile, if that file exists.  After reading that file, it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads and executes commands from the first one that exists and is readable.

## L33tme.sh
Init script for your pentesting needs.
