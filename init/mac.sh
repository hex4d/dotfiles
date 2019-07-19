# Homebrew
export PATH=/usr/local:$PATH
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# zsh
brew install zsh
echo /usr/local/bin/zsh | sudo tee -a /etc/shells

brew install fzy

# python
brew install python3

# neovim
brew install neovim
pip3 install neovim
pip3 install neovim-remote

# utils
brew install gtags
brew install thefuck
brew install jq
brew install ripgrep

# node
brew install nodebrew
nodebrew install latest
nodebrew use latest
npm install -g neovim

# hub
brew install hub

# yarn
brew install yarn

# font
git clone https://github.com/miiton/Cica.git
cd Cica
docker-compose build ; docker-compose run --rm cica  # ./dist/ に出力される

echo 'You need to set font to iterm2'
