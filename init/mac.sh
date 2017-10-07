# Homebrew
export PATH=/usr/local:$PATH
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# zsh
brew install zsh
echo /usr/local/bin/zsh | sudo tee -a /etc/shells

# python
brew install python3

# neovim
brew install neovim
pip3 install neovm
pip3 install neovim-remote



