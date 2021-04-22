autoload -U colors
colors
export TERM=screen-256color

autoload U compinit
compinit -u

# vim key bind
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -a 'q' push-line

# zplug
if [ ! -e $HOME/.zplug ]; then
  git clone https://github.com/zplug/zplug $HOME/.zplug
fi
source ~/.zplug/init.zsh

# # syntax
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

alias
alias reload='exec $SHELL -l'

function nvcd() {
  nvr -c 'cd '${PWD}
}

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
add-zsh-hook precmd vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}-"
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
    if [ $TTYIDLE -gt 1 ] && [ $notif_status -ne 130 ] && [ $notif_status -ne 146 ]; then
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

# PATH=$PATH:~/.nodebrew/current/bin
PATH=$PATH:/usr/local/bin
export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=~/Library/Android/sdk
PATH=$PATH:$ANDROID_HOME/emulator
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/tools/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/bin
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
PATH=$PATH:$JAVA_HOME/bin
# PATH=$PATH:~/.nodebrew/current/bin
PATH=$PATH:./node_modules/.bin

add-zsh-hook precmd _precmd
add-zsh-hook preexec _preexec

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
##-end-npm-completion-###

eval $(thefuck --alias)
alias fk=fuck

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
fpath=(~/.zsh/completion $fpath)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

autoload -Uz compinit && compinit -i
eval "$(pyenv init -)"

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm
nvm use default

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

function chpwd() { echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print $1"/"$2}'| rev)\007"}

