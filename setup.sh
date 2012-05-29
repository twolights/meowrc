#!/bin/bash

HOME_BIN=~/bin
HOME_VIM=~/.vim
VIM_BUNDLE=$HOME_VIM/bundle
VUNDLE_HOME=$VIM_BUNDLE/vundle
MEOWRC_HOME=~/.meowrc
MEOWRC_BIN=$MEOWRC_HOME/bin
MEOWRC_VIM=$MEOWRC_HOME/vim

RC_ITEMS=".zshrc .vimrc .screenrc"

mkdir -p $VIM_BUNDLE
if [ ! -d $VIM_BUNDLE ]; then
    echo 'Installing vundle...'
    git clone https://github.com/gmarik/vundle.git $VUNDLE_HOME
fi

if [ ! -d $MEOWRC_HOME ]; then
    echo 'Installing meowrc...'
    git clone https://github.com/twolights/meowrc $MEOWRC_HOME
else
    echo -n 'Updating meowrc...'
    pushd $MEOWRC_HOME
    git pull origin master
    popd
fi

echo -n "Linking rc's... "
for rc in $RC_ITEMS; do
    ln -fs $MEOWRC_HOME/$rc ~/
done
echo 'done!'

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

vim +BundleInstall +qa
