export CONF_HOME=/tmp/pyrrvs.confs
echoerr() { echo "$@" 1>&2; exit 1; }

zsh=`which zsh`
if [ -z $zsh ]
then
    echoerr "Error: zsh is not installed. Please install zsh and re-run this script"
    exit 1
fi

git=`which git`
if [ -z $git ]
then
    echoerr "Error: git is not installed. Please install git and re-run this script"
    exit 1
fi

emacs=`which emacs`
if [ -z $emacs ]
then
    echoerr "Error: emacs is not installed. Please install emacs and re-run this script"
    exit 1
fi

tmux=`which tmux`
if [ -z $tmux ]
then
    echoerr "Error: tmux is not installed. Please install tmux and re-run this script"
    exit 1
fi

golang=`which go`
if [ ! -z $golang ]
then
    echo "Golang is installed. We'll import modules for emacs"
    go get golang.org/x/tools/cmd/oracle
fi

if [ -d $CONF_HOME/.git  ]
then
    echo "Updating configuration"
    (cd $CONF_HOME && git pull origin master)
else
    echo "Cloning configuration repository"
    git clone https://github.com/Pyrrvs/confs.git $CONF_HOME || echoerr "Failed cloning repository"
    echo "Cloning Tools:"
    echo "* libphutil"
    git clone https://github.com/phacility/libphutil.git $CONF_HOME/tools/libphutil || echoerr "Failed cloning repository"
    echo "* arcanist"
    git clone https://github.com/phacility/arcanist.git $CONF_HOME/tools/arcanist || echoerr "Failed cloning repository"
fi

export ZSH=$CONF_HOME/oh-my-zsh
export ZSH_CUSTOM=$CONF_HOME/zsh
if [ ! -e $ZSH_CUSTOM/env.zsh ]
then
    cp -f $CONF_HOME/zsh-templates/env.zsh-template $ZSH_CUSTOM/env.zsh
    echo "export CONF_HOME=\"$CONF_HOME\"" >> $ZSH_CUSTOM/env.zsh
    echo "export ZSH=\"$ZSH\"" >> $ZSH_CUSTOM/env.zsh
    echo "export ZSH_CUSTOM=\"$ZSH_CUSTOM\"" >> $ZSH_CUSTOM/env.zsh
    echo "export GOROOT=\"$GOROOT\"" >> $ZSH_CUSTOM/env.zsh
    echo "export GOPATH=\"$GOPATH\"" >> $ZSH_CUSTOM/env.zsh
fi
    
if [ ! -e $ZSH ]
then
    echo "Cloning oh-my-zsh"
    git clone http://github.com/robbyrussell/oh-my-zsh.git $CONF_HOME/oh-my-zsh
    cp $CONF_HOME/oh-my-zsh/templates/zshrc.zsh-template $CONF_HOME/.zshrc
    sed "/^export ZSH=/ c\\
export ZSH=$ZSH" $CONF_HOME/.zshrc > $CONF_HOME/.zshrc-omztemp
    mv -f $CONF_HOME/.zshrc-omztemp $CONF_HOME/.zshrc
fi

if [ ! -d $CONF_HOME/cask ]
then
    echo "Installing Cask"
    git clone https://github.com/cask/cask.git $CONF_HOME/cask
    export PATH=$PATH:$CONF_HOME/cask/bin
    echo "Bootstraping Cask"
    cask upgrade-cask
    cp $CONF_HOME/cask/cask.el $CONF_HOME/emacs/
fi

(cd $CONF_HOME/emacs && cask install)

# if [ -z `grep "$CONF_HOME/zshrc" ~/.zshrc` ]
# then
#     echo "Customizing .zshrc"
#     sed -i 's/\# \(DISABLE_AUTO_TITLE="true"\)/\1/' ~/.zshrc
#     echo >> ~/.zshrc
#     echo "source $CONF_HOME/zsh/zshrc" >> ~/.zshrc
# fi

# echo "Installing emacs dependencies"
# (cd $CONF_HOME/emacs && bash install_dependencies.sh)

echo "Installation is over, we'll run a customize zsh for you and clean up after you leave"
#echo "source $CONF_HOME/zshrc" | env zsh -d -f
ZDOTDIR=$CONF_HOME zsh

echo "zsh session closed, cleaning up."
rm -rf $CONF_HOME
