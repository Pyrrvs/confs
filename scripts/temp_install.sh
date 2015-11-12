export TMP_CONF_HOME=/tmp/pyrrvs.confs

curl=`which curl`
wget=`which wget`
if [ ! -z $curl ]
then
    curl -L https://raw.github.com/Pyrrvs/confs/master/scripts/install.sh | sh
elif [ ! -z $wget ]
then
    wget https://raw.github.com/Pyrrvs/confs/master/scripts/install.sh -O - | sh
else
    echo "We need either curl or wget to run this script"
    exit 1
fi

ZDOTDIR=$TMP_CONF_HOME env zsh

echo "Temporary installation session closed, cleaning up."
rm -rf $TMP_CONF_HOME
