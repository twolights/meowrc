# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="ykchen"

export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export LC_CTYPE=$LANG

export REPORTTIME=2

# Let zsh automatically report tasks that run over 60 seconds when done
export AUTO_REPORT_LONGTASKS_THRESHOLD=60

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git macos pip git-flow vi-mode zsh-syntax-highlighting docker docker-compose meteor kubectl terraform aws auto-report-longtasks gcloud)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

if [ -f ~/.local_zshrc ]; then
    source ~/.local_zshrc
fi

current_os=`uname -s`
if [ $current_os = 'Linux' ]; then
    alias ls='ls -aF --color' 
elif [ $current_os = 'Darwin' ]; then
    alias ls='ls -aGF'
    alias xcb=xcodebuild
    alias locate=mdfind
    eval "$(brew shellenv)"
    autoload -Uz compinit
    compinit
else
    alias ls='ls -aGF'
fi  

ptipython_check=`which ptipython`
if [ -x $ptipython_check ]; then
    alias ipy='ptipython --vi'
else
    alias ipy=ipython
fi

unset ptipython_check

bat_check=`which bat`
batcat_check=`which batcat`

if [ -x $batcat_check ]; then
    alias cat=batcat
elif [ -x $batcat_check ]; then
    alias cat=bat
fi

unset bat_check
unset batcat_check

alias ans=ansible
alias g=egrep
alias h='history'
alias jl='jobs -l'
alias k=kubectl
alias keeptell='run-and-notify.sh 1'
alias m='meteor'
alias mk='minikube'
alias mssh='mosh --ssh=ssh'
alias mv='mv -i'
alias n=nslookup
alias p="ps -axwww"
alias psm="psu $USER"
alias psr="psu root"
alias psu="ps -w -U"
alias py=python
alias rm='rm -i'
alias sc='scons -Q'
alias scp='scp -oProtocol=2'
alias ssh='ssh -C -2'
alias t='telnet'
alias tell='run-and-notify.sh 0'
alias tempboard='echo -n -e "\033]0;Pasteboard\007"'
alias termcolor='env TERM=xterm-color'
alias tf=terraform
# alias vim='nvim'
# alias vimdiff='nvim -d'

unalias history

export EDITOR=vim
export VISUAL=vim

export PATH=/usr/local/bin:/usr/local/sbin:/sbin:$PATH:~:~/bin:/opt/homebrew/bin:.

setopt extendedhistory
export HISTTIMEFORMAT="%y-%d-%m_%H:%M:%S "
export KEYTIMEOUT=1

stty erase '' >& /dev/null

export ANDROID_HOME=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools:${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:~/.local/bin

man () {
    /usr/bin/man $@ | col -b | vim -R -c 'set ft=man nomod nolist' -
}

if [ -d "env" ]; then
    echo "Python virtual environment detected in current path [$PWD/env], activating it"
    . env/bin/activate
elif [ -d ".venv" ]; then
    echo "Python virtual environment detected in current path [$PWD/.venv], activating it"
    . .venv/bin/activate
fi
