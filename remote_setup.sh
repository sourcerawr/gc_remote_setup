# to install things on the cloud

# system information
lscpu
free -h
df -h
lsb_release -a
lspci | grep VGA

# yn prompt to continue
read -p "Continue? (y/n) " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Continuing..."
else
    echo "Exiting..."
    exit 1
fi

# updating packages
# asking if you want to update - otherwise skipping to installing
read -p "Update packages? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get update
    sudo apt-get upgrade
else
    echo "Skipping update..."
fi

# installing python packages
# jupyter notebook; tensorflow; pandas; numpy; matplotlib; seaborn; scikit-learn
sudo apt-get install python3-pip
pip3 install jupyter
pip3 install tensorflow
pip3 install pandas
pip3 install numpy
pip3 install matplotlib
pip3 install seaborn
pip3 install scikit-learn