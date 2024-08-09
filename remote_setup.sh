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

# jupyter notebook; tensorflow; pandas; numpy; matplotlib; seaborn; scikit-learn
sudo apt-get install git
sudo apt-get install gh

# asking if you want to authenticate gh
read -p "Authenticate gh? (y/n) " -n 1 -r
# authenticate gh
if [[ $REPLY =~ ^[Yy]$ ]]
then
    gh auth login
    git config --global user.email "ashwary0102@gmail.com"
    git config --global user.name "Ashwary Sharma"
else
    echo "Skipping gh authentication..."
fi

# installing python packages
# asking
read -p "Install python packages? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get install python3
    sudo apt-get install python3-pip
    pip3 install python-language-server
    pip3 install jupyter
    pip3 install tensorflow
    pip3 install pandas
    pip3 install numpy
    pip3 install matplotlib
    pip3 install seaborn
    pip3 install scikit-learn
    pip3 install plotly
    pip3 install transformers
else
    echo "Skipping python packages..."
fi

# asking if you want shell upgrade to zsh
# installing zsh and powerlevel10k theme
read -p "Upgrade shell to zsh? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get install zsh
    echo 'if [ -t 1 ]; then exec zsh; fi' >> ~/.bashrc
    # chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    # echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc
    # source ~/.zshrc
else
    echo "Skipping shell upgrade..."
fi

# installing VS Code extensions - python, copilot, jupyter, errorlens, data wranglera, gitlens - let's first see which all are needed
# asking
read -p "Install VS Code extensions? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    code --install-extension ms-python.python
    code --install-extension github.copilot
    code --install-extension ms-toolsai.jupyter
    code --install-extension ms-data.data-wrangler
else
    echo "Skipping VS Code extensions..."
fi