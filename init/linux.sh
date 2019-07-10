sudo apt-get -y install git
sudo apt-get -y install zsh
sudo chsh /usr/bin/zsh

wget https://github.com/jhawthorn/fzy/releases/download/0.9/fzy_0.9-1_amd64.deb
sudo dpkg -i fzy_0.9-1_amd64.deb

sudo apt-get -y install python3-pip
pip3 install --upgrade pip

# depend: python
# neovim
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim

pip3 install neovim
pip3 install neovim-remote

sudo pip3 install thefuck

sudo apt-get -y install jq

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb
