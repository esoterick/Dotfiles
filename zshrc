HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

# zstyle :compinstall filename "$HOME/.zshrc"

autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -U promptinit && promptinit
autoload -U add-zsh-hook
autoload -U vcs_info && vcs_info

zmodload zsh/complist
zmodload zsh/terminfo

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# setopt
setopt \
  autocd \
  ksh_glob \
  extendedglob \
  prompt_subst \
  inc_append_history

bindkey -v

for r in $HOME/.zsh/*.zsh; do
  if [[ $DEBUG > 0 ]]; then
    echo "zsh: sourcing $r"
  fi
  source $r
done

eval $( dircolors -b $HOME/.zsh/LS_COLORS/LS_COLORS )
export LS_COLORS

export PATH="$HOME/.cask/bin:$PATH"

#alias ls='ls --color'
alias ls='ls++ --potsf'
alias resoteric='rdesktop -g 90% 10.0.0.10'
alias grep='grep --color'
alias emacsc='emacsclient -n -c'
alias cp='cp -v'

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

export RUST_SRC_PATH=/usr/local/src/rustc-nightly/src
export PATH=/usr/local/heroku/bin:$PATH
export CLOUDSDK_PYTHON=/usr/bin/python2

# The next line updates PATH for the Google Cloud SDK.
source '/home/rlambert/google-cloud-sdk/path.zsh.inc'

# The next line enables zsh completion for gcloud.
source '/home/rlambert/google-cloud-sdk/completion.zsh.inc'
