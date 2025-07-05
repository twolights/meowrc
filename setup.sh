#!/bin/bash

OS=$(uname)

HOME_BIN=~/bin
HOME_CONFIG=~/.config
HOME_VIM=~/.vim
OH_MY_ZSH=~/.oh-my-zsh
OH_MY_ZSH_PLUGIN=$OH_MY_ZSH/custom/plugins
ZSH_SYNTAX_HIGHLIGHT_PLUGIN=$OH_MY_ZSH_PLUGIN/zsh-syntax-highlighting
AUTO_REPORT_LONGTASKS_PLUGIN=$OH_MY_ZSH_PLUGIN/auto-report-longtasks
VIM_BUNDLE=$HOME_VIM/bundle
VUNDLE_HOME=$VIM_BUNDLE/vundle
MEOWRC_HOME=~/.meowrc
MEOWRC_BIN=$MEOWRC_HOME/bin
MEOWRC_VIM=$MEOWRC_HOME/vim

SECRETS_HOME=~/.secrets

RC_ITEMS=".zshrc .vimrc .screenrc .gitconfig .gitignore_global .inputrc .tmux.conf"

mkdir -p $VIM_BUNDLE
if [ ! -d $VUNDLE_HOME ]; then
    echo 'Installing vundle...'
    git clone https://github.com/gmarik/vundle.git $VUNDLE_HOME
fi

if [ ! -d $OH_MY_ZSH ]; then
    echo 'Installing oh-my-zsh...'
    git clone https://github.com/robbyrussell/oh-my-zsh.git $OH_MY_ZSH
fi

ln -fs $MEOWRC_HOME/ykchen.zsh-theme $OH_MY_ZSH/themes/
mkdir -p $OH_MY_ZSH_PLUGIN
pushd $OH_MY_ZSH_PLUGIN
if [ ! -d $ZSH_SYNTAX_HIGHLIGHT_PLUGIN ]; then
    echo 'Installing zsh-syntax-highlighting...'
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHT_PLUGIN
else
    echo 'Updating zsh-syntax-highlighting...'
    pushd $ZSH_SYNTAX_HIGHLIGHT_PLUGIN
    git pull origin master
    popd
fi
popd

if [ ! -d $MEOWRC_HOME ]; then
    echo 'Installing meowrc...'
    git clone https://github.com/twolights/meowrc $MEOWRC_HOME
else
    echo -n 'Updating meowrc...'
    pushd $MEOWRC_HOME
    git pull origin master
    popd
fi

echo -n 'Linking zsh plugin: auto-report-longtasks...'
mkdir -p $AUTO_REPORT_LONGTASKS_PLUGIN
ln -fs $MEOWRC_HOME/auto-report-longtasks.plugin.zsh $AUTO_REPORT_LONGTASKS_PLUGIN/
echo 'done!'

echo -n "Linking rc's... "
for rc in $RC_ITEMS; do
    ln -fs $MEOWRC_HOME/$rc ~/
done
echo 'done!'

mkdir -p $HOME_BIN/
echo -n "Linking scripts... "
for script in $MEOWRC_BIN/*; do
    ln -fs $script $HOME_BIN/
done
echo 'done!'

echo -n "Linking vim directories... "
for d in $MEOWRC_VIM/*; do
    ln -fs $d $HOME_VIM/
done
echo 'done!'

echo -n "Creating secrets directory... "
mkdir -p $SECRETS_HOME
chmod 700 $SECRETS_HOME
echo 'done!'

echo -n "Creating .config directory... "
mkdir -p $HOME_CONFIG
echo 'done!'

echo "Setting up AstroNvim..."
rm -fr $HOME_CONFIG/nvim
git clone --depth 1 https://github.com/AstroNvim/template $HOME_CONFIG/nvim
rm -fr $HOME_CONFIG/nvim/.git
echo 'done!'
ln -sf $MEOWRC_HOME/nvim/theme.lua $HOME_CONFIG/nvim/lua/plugins/
ln -sf $MEOWRC_HOME/nvim/copilot-chat.lua $HOME_CONFIG/nvim/lua/plugins/
ln -sf $MEOWRC_HOME/nvim/polish.lua $HOME_CONFIG/nvim/lua/
ln -sf $MEOWRC_HOME/nvim/community.lua $HOME_CONFIG/nvim/lua/
ln -sf $MEOWRC_HOME/nvim/astrolsp.lua $HOME_CONFIG/nvim/lua/plugins/
echo

vim +'BundleInstall!' +qa
