#!/bin/bash
set -e  # Exit on error
echo "Starting Vast.ai instance setup..."

# to install things on the cloud

# system information
lscpu
free -h
df -h
lsb_release -a
lspci | grep VGA
nvidia-smi

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

# packages
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
    conda install -y \
        jupyter \
        pandas \
        numpy \
        matplotlib \
        seaborn \
        scikit-learn \
        plotly \
        transformers \
        pytorch \
        torchvision \
        torchaudio \
        cudatoolkit

    # Register the kernel
    python -m ipykernel install --user --name python3 --display-name "Python (base)"
else
    echo "Skipping python packages..."
fi

# asking if you want to set up working directory
read -p "Set up working directory? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mkdir -p ./cloud_workspace
    cd ./cloud_workspace

# asking if you want shell upgrade to zsh
# installing zsh and powerlevel10k theme
read -p "Upgrade shell to zsh? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get install zsh
    echo 'if [ -t 1 ]; then exec zsh; fi' >> ~/.bashrc
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # chsh -s $(which zsh)
    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    # echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >>~/.zshrc
    # source ~/.zshrc
else
    echo "Skipping shell upgrade..."
fi

# Add new Jupyter setup section before VS Code extensions
read -p "Setup Jupyter? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Create Jupyter config
    jupyter notebook --generate-config
    
    # Setup password
    jupyter notebook password
    
    # Configure Jupyter
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
    echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py
fi

# installing VS Code extensions - python, copilot, jupyter, errorlens, data wranglera, gitlens - let's first see which all are needed
# asking
read -p "Install VS Code extensions? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    code --install-extension ms-python.python
    code --install-extension github.copilot
    code --install-extension ms-toolsai.jupyter
    code --install-extension ms-toolssai.datawrangler
    code --install-extension mechatroner.rainbow-csv 
else
    echo "Skipping VS Code extensions..."
fi