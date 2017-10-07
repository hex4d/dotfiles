autoload -U colors
colors
export TERM=screen-256color

autoload U compinit
compinit -u

# Vim キーバインド
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

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

 
PROMPT="%F{blue}[%D %*]%f %d %% "

alias reload='exec $SHELL -l'

function nvcd() {
  nvr -c 'cd '${PWD}
}



autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
