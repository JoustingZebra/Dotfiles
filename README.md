# Dotfiles
A personal collection of configuration files.

### So, what are these files?

## ~.bashrc
Run configuration for [BASH](https://tiswww.case.edu/php/chet/bash/bashtop.html). (The individual per-interactive-shell BASH startup file)

From the BASH man page:
> When an interactive shell that is not a login shell is started, bash reads and executes commands from ~/.bashrc, if that file exists.  This may be inhibited by using the --norc option.  The --rcfile file option will force bash to read and execute commands from file instead of ~/.bashrc.

### Installation

Backup current .bashrc:

  ```mv .bashrc .bashrc.bak```

Curl new .bashrc:

  ``` curl -O https://raw.githubusercontent.com/JoustingZebra/Dotfiles/main/.bashrc```

Load new .bashrc:

  ``` source .bashrc ```

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

### Available prompts:

Change to any of the following prompts on the fly: ``` prompt --<flag>```

for example ``` prompt --classic```

**Prompts**
| Prompt style | flag |
| ------------- | ------------- |
| Default  | --reset  |
| Classic  | --classic |
| Custom  | --custom |
| Custom2 | --custom2 |
| Lean  | --lean |
| Parrot| --parrot |
| Redhat| --redhat |
| Suse| --suse |
| Ubuntu| --ubuntu |
| ZSH | --zsh | 

Default:

The "2" in this prompt is the ```$BASH_SUBSHELL``` variable, which increments by one every time you spawn a new shell. The "0" is the "$?" variable (exit status of the last command) 


![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/default_prompt.PNG)

Classic:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/classic_prompt.PNG)

Custom:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/custom_prompt.PNG)


Custom2:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/custom2_prompt.PNG)

Lean:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/lean.PNG)

Parrot:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/parrot.PNG)

Redhat:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/redhat.PNG)

Suse:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/suse.PNG)

Ubuntu:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/ubuntu.PNG)

ZSH:

![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/zsh.PNG)

                             
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

### Photo:
![alt text](https://github.com/JoustingZebra/Dotfiles/blob/main/Images/profile.PNG)

## L33tm3.sh
Init script for your pentesting needs.
- Requires sudo.
- Updates your system in a safe way for rolling distros.
- User is prompted for Kali Linux and Parrot OS repo imports and metapackage installs. (L33tm3.sh is smart and will not pull repos that are already present. It does not bloat your system)
- Pulls and sources the above config files.
- Pulls common tools.
