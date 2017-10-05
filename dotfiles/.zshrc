autoload -U colors
colors
export TERM=screen-256color

autoload U compinit
compinit -u

# Vim キーバインド
bindkey -v

PROMPT="[%D %*] %d %% "

# zplug

source ~/.zplug/init.zsh

# syntax
zplug "zsh-users/zsh-syntax-highlighting", nice:10

antigen bundle zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-syntax-highlighting

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose


bindkey -M viins 'jj' vi-cmd-mode
 
function nvcd() {
  nvr -c 'cd '${PWD}
}

