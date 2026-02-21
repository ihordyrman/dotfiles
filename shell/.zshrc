# if not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt HIST_IGNORE_DUPS       # ignore duplicate commands
setopt APPEND_HISTORY         # append to history file
setopt SHARE_HISTORY          # share history between sessions

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gallois"
plugins=(git)

export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=never'
alias ll='ls -alF --color=never'
alias la='ls -A --color=never'
alias l='ls -CF --color=never'alias cls='clear'

alias k='kubectl'
alias hh=hstr

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

discord_update() {
  curl -L -X GET --output "/home/ihor/Downloads/discord-latest.deb"  "https://discord.com/api/download?platform=linux"
  sudo dpkg -i /home/ihor/Downloads/discord-latest.deb && sudo rm /home/ihor/Downloads/discord-latest.deb
  echo "New version installed"
}

hg() {
    history | grep "$@"
}

decode_html() {
    local dir="${1:-.}"
    
    find "$dir" -name "*.md" -type f -exec sed -i \
        -e 's/<span[^>]*>//g' \
        -e 's/<\/span>//g' \
        -e 's/<br\s*\/?>/\
/g' \
        -e 's/&nbsp;/ /g' \
        -e 's/&lt;/</g' \
        -e 's/&gt;/>/g' \
        -e 's/&le;/≤/g' \
        -e 's/&ge;/≥/g' \
        -e 's/&amp;/\&/g' \
        -e 's/&quot;/"/g' \
        -e "s/&apos;/'/g" \
        -e 's/&copy;/©/g' \
        -e 's/&reg;/®/g' \
        -e 's/&trade;/™/g' \
        -e 's/&mdash;/—/g' \
        -e 's/&ndash;/–/g' \
        -e 's/&hellip;/…/g' \
        {} +
}

export HSTR_CONFIG=hicolor
bindkey -s "\C-r" "\C-a hstr -- \C-j"
export HSTR_TIOCSTI=n

export DOTNET_ROOT=$HOME/.dotnet
export PATH="$PATH:/home/ihor/.dotnet/tools"
export PATH=$HOME/.dotnet:$PATH

source ~/.z.sh

eval $(opam env --switch=5.4.0)
eval "$(zellij setup --generate-auto-start zsh)"

source $ZSH/oh-my-zsh.sh

unset LS_COLORS
# export LS_COLORS="di=00:ow=00:tw=00:st=00"
export LS_COLORS="di=01;34:ow=01;34:tw=01;34:ln=01;36:ex=01;32:*.log=33"
export LC_TIME=en_US.UTF-8

export PATH="$HOME/.local/bin:$PATH"
