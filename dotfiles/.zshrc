# PATH
export PATH=/usr/local/bin:/Applications/XAMPP/bin:$PATH
# export PATH=/Users/kobasho/.nodebrew/current/bin:$PATH
# 色を使用できるように
autoload -U colors
colors
export TERM=screen-256color

alias cw="cd ~/Documents/Workspace"

autoload U compinit
compinit -u

# Vim キーバインド
bindkey -v

PROMPT="[%D %*] %d %% "

function nvcd() {
  nvr -c 'cd '${PWD}
}
