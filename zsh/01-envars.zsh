# HOMEs
#export XDG_CONFIG_HOME="$HOME/etc"
#export XDG_CACHE_HOME="$HOME/etc/cache"
#export XDG_DATA_HOME="$HOME/var"
#export DEVEL_HOME="$HOME/dev"
#export BIN_HOME="$HOME/bin"
#
#export LANG="de_DE.utf8"
#
#export PATH="$PATH:$BIN_HOME:/sbin:/usr/sbin:/usr/local/bin:/opt/jre1.6.0_29/bin"
#
## JAVA
##export LD_LIBRARY_PATH=/usr/lib/jre1.7.0/lib/amd64
#export LD_LIBRARY_PATH=/opt/jre1.6.0_29/lib/

export HISTSIZE=1000
export SAVEHIST=1000
#export HISTFILE=$XDG_CONFIG_HOME/zsh/history
export DISPLAY=:0

export SHELL='/bin/zsh'
export EDITOR='vim'
export MANPAGER='vimpager'

export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH=~/.cabal/bin/:$PATH
export PATH=~/bin/:$PATH

# The next line updates PATH for the Google Cloud SDK.
source '/home/rlambert/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/home/rlambert/google-cloud-sdk/completion.zsh.inc'

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/jre
export AWS_RDS_HOME=/home/rlambert/Tools/RDSCli-1.19.004
export PATH=$PATH:$AWS_RDS_HOME/bin
export EC2_REGION=us-east-1

export PATH=$PATH:$HOME/google_appengine

export PATH=$PATH:$HOME/go_appengine/

source /home/rlambert/.rvm/scripts/rvm

export KUBERNETES_PROVIDER=vagrant
