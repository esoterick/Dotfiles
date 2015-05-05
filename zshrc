HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"

autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -U promptinit && promptinit
autoload -U add-zsh-hook

setopt promptsubst

function ssh_state {
    if [ -n "$SSH_CONNECTION" ]; then
        echo "%{$fg[red]%}<%{$fg[white]%}SSH%{$fg[red]%}> "
    fi
}

function collapse_pwd {
    if [[ $(pwd) == $HOME ]]; then
        echo $(pwd)
    else
        echo $(pwd | sed -e "s,^$HOME,~,")
    fi
}

function error_code {
    if [[ $? == 0 ]]; then
        echo ""
    else
        echo "%{$fg[white]%}<%{$fg[red]%}%?%{$fg[white]%}>%{$reset_color%}"
    fi
}

function get_wifi_ip {
    ip addr show wlp3s0b1 | egrep "inet\s" | awk '{ print $2}' | cut -d "/" -f1
}

last_command="%(?.>>.<<)"

set_prompt () {
    PROMPT="%{$fg[red]%}>> %{$fg[white]%}$(whoami) %{$fg[red]%}>> %{$fg[white]%}$(get_wifi_ip) %{$fg[red]%}>> %{$fg[white]%}$(collapse_pwd)%{$fg[red]%} >> $(ssh_state)
%{$fg[white]%}$last_command%{$reset_color%} "
    RPROMPT="$(error_code)%{$reset_color%}"
}

add-zsh-hook precmd set_prompt

export PATH="$HOME/.cask/bin:$PATH"

alias ls='ls --color'
alias resoteric='rdesktop -g 90% 10.0.0.10'
alias grep='grep --color'
alias emacsc='emacsclient -n -c'

function pmgrep { sudo pacman -Ss $* | grep $* -A 1 }

function update_mirrors {
    sudo reflector --verbose -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist
}

function gpg_start {
    gnupginf="${HOME}/.gnupg/gpg-agent-info"
    if pgrep -u "${USER}" gpg-agent >/dev/null 2>&1; then
        source $gnupginf
    else
        gpg-agent --daemon > $gnupginf
    fi
}

function src() {
    autoload -U zrecompile
    [ -f ~/.zshrc ] && zrecompile -p ~/.zshrc
    [ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
    [ -f ~/.zcompdump ] && zrecompile -p ~/.zcompdump
    [ -f ~/.zshrc.zwc.old ] && rm -f ~/.zshrc.zwc.old
    [ -f ~/.zcompdump.zwc.old ] && rm -f ~/.zcompdump.zwc.old
    source ~/.zshrc
}

eval $(ssh-agent) >/dev/null 2>&1

gpg_start
