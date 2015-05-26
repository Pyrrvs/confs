export CONF_HOME=~/.confs

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

tmux=`which zsh`
if [ -z $tmux ]
then
    echoerr "Error: tmux is not installed. Please install tmux and re-run this script"
    exit 1
fi

read -s -p "Enter Password: " password

if [ ! `basename $zsh` = "zsh" ]
then
    echo "Using zsh as default shell"
    echo $password | chsh -s $zsh || echoerr "Failed changing shell to zsh"
fi

if [ ! -e ~/.oh-my-zsh ]
then
    echo "Installing oh-my-zsh"
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed "s/chsh/echo \$password \| chsh/" | sed "s/\. \~\/\.zshrc//" | source /dev/stdin || echoerr "Failed installing oh-my-zsh"
fi

if [ ! -e $CONF_HOME  ]
then
    echo "Cloning configuration repository"
    git clone https://github.com/Pyrrvs/confs.git $CONF_HOME || echoerr "Failed cloning repository"
    echo "Cloning Tools:"
    echo "* libphutil"
    git clone https://github.com/phacility/libphutil.git $CONF_HOME/tools/libphutil|| echoerr "Failed cloning repository"
    echo "* arcanist"
    git clone https://github.com/phacility/arcanist.git $CONF_HOME/tools/arcanist || echoerr "Failed cloning repository"
fi


if [ -z `grep "$CONF_HOME/zshrc" ~/.zshrc` ]
then
    echo "Customizing .zshrc"
    sed -i 's/\# \(DISABLE_AUTO_TITLE="true"\)/\1/' ~/.zshrc
    echo >> ~/.zshrc
    echo "source $CONF_HOME/zsh/zshrc" >> ~/.zshrc
fi

echo "Installing emacs dependencies"
(cd $CONF_HOME/emacs && bash install_dependencies.sh)

echo "Installation is over, now run zsh"
