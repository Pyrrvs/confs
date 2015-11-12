export TMP_CONF_HOME=/tmp/pyrrvs.confs

curl=`which curl`
wget=`which wget`
if [ ! -z $curl ]
then
    sh -c "$(curl -L https://raw.github.com/Pyrrvs/confs/master/scripts/install.sh)"
elif [ ! -z $wget ]
then
    sh -c "$(wget https://raw.github.com/Pyrrvs/confs/master/scripts/install.sh -O -)"
else
    echo "We need either curl or wget to run this script"
    exit 1
fi

echo "Temporary installation session closed, cleaning up."
rm -rf $TMP_CONF_HOME
