autoload -U colors
colors
export TERM=screen-256color

autoload U compinit
compinit -u

# Vim キーバインド
bindkey -v

PROMPT="[%D %*] %d %% "

# zplug

if [ ! -e $HOME/.zplug ]; then
	git clone https://github.com/zplug/zplug $HOME/.zplug
fi
source ~/.zplug/init.zsh

# syntax
zplug "zsh-users/zsh-syntax-highlighting", defer:2

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

