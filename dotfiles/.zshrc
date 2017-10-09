autoload -U colors
colors
export TERM=screen-256color

autoload U compinit
compinit -u

# vim key bind
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

# alias
alias reload='exec $SHELL -l'

function nvcd() {
  nvr -c 'cd '${PWD}
}

# prompt 
PROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
add-zsh-hook precmd vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

autoload -Uz terminfo

terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        main|viins)
            PROMPT_2="$fg[cyan]-- INSERT --$reset_color"
            ;;
        vicmd)
            PROMPT_2="$fg[white]-- NORMAL --$reset_color"
            ;;
        vivis|vivli)
            PROMPT_2="$fg[yellow]-- VISUAL --$reset_color"
            ;;
    esac

    PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}%F{blue}%m%f %d %% "
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

# search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -v "^K" history-beginning-search-backward-end
bindkey -v "^J" history-beginning-search-forward-end

# hook
if [ $(uname) = "Darwin" ]; then
  _preexec() {
    notif_prev_command=$2
  }
  _precmd() {
    notif_status=$?
    if [ $TTYIDLE -gt 10 ] && [ $notif_status -ne 130 ] && [ $notif_status -ne 146 ]; then
      notif_title=$([ $notif_status -eq 0 ] && echo "Command succeeded" || echo "Command failed")
      notif_color=$([ $notif_status -eq 0 ] && echo "good" || echo "danger")
      osascript -e 'display notification "'$notif_prev_command'" subtitle "'$TTYIDLE' seconds" with title "'$notif_title'" sound name ""'
    fi
  }
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  precmd() {
    [ $TTYIDLE -gt 5 ] && echo "finished"
  }
fi

add-zsh-hook precmd _precmd
add-zsh-hook preexec _preexec

