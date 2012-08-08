# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="ykchen"

export LANG="zh_TW.UTF-8"

export REPORTTIME=2

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
plugins=(git osx pip git-flow brew django vi-mode)

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
else
    alias ls='ls -aGF'
fi  

alias g=egrep
alias h='history'
alias ipy=ipython
alias j='jobs -l'
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

unalias history

export EDITOR=vim
export VISUAL=vim

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:~:~/bin:.

setopt extendedhistory
export HISTTIMEFORMAT="%y-%d-%m_%H:%M:%S "

stty erase '' >& /dev/null

[[ -s "/Users/ykchen/.rvm/scripts/rvm" ]] && source "/Users/ykchen/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
