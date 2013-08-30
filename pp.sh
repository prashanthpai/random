# This script is to be placed in /etc/profile.d/
# Will be loaded in environment of all users

### Functions ###

# Adds string to PATH variable
function addtopath()
{
    echo "$PATH" | grep -qw "$1"
    if [ $? -ne 0 ]; then
        export PATH=$PATH:$1
        return 0;
    else
        return 1;
    fi
}

# Generic extract function
function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.tar.xz)    tar xvf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Remove all xattr from a directory
function resetbrick()
{
        echo "Removing xattrs from $1..."
        for i in `attr -lq $1`; do
                echo "Removing $i"
                setfattr -x trusted.$i $1;
        done
        echo "Deleting .glusterfs directory from $1..."
        rm -rf $1/.glusterfs
}

# Creates an archive (*.tar.gz) from given directory.
function maketar()
{
	tar cvzf "${1%%/}.tar.gz"  "${1%%/}/";
}

# Coloured man pages
man() {
        env \
                LESS_TERMCAP_mb=$(printf "\e[1;31m") \
                LESS_TERMCAP_md=$(printf "\e[1;31m") \
                LESS_TERMCAP_me=$(printf "\e[0m") \
                LESS_TERMCAP_se=$(printf "\e[0m") \
                LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
                LESS_TERMCAP_ue=$(printf "\e[0m") \
                LESS_TERMCAP_us=$(printf "\e[1;32m") \
                        man "$@"
}

# Add custom shell scripts to PATH
addtopath /home/ppai/bin/

# Command history settings
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=10000000
export HISTSIZE=10000
export HISTTIMEFORMAT="%h %d %H:%M:%S> "
export HISTIGNORE="history*:cd:ls:c:[bf]g:exit:pwd:clear:mount:[ \t]*"
shopt -s histappend
shopt -s cmdhist
shopt -q -s cdspell
set -o notify

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias path='echo -e ${PATH//:/\\n}'
alias c='clear'
alias updatedb='sudo updatedb'
alias locate='sudo locate'
alias pip="/usr/bin/pip-python"
alias todo='vim /home/ppai/todo'
alias hibernate='sudo systemctl hibernate'

# Use vimx for X11-clipboard support
if [ -e /usr/bin/vimx ];
then
  alias vim='/usr/bin/vimx';
fi

export GREP_OPTIONS='--color=auto'
export CSCOPE_EDITOR=vim

# SSH and VM aliases
alias vm1='ssh ppai@192.168.56.101'
alias vm2='ssh ppai@192.168.56.102'
alias vm3='ssh ppai@192.168.56.103'

ulimit -c unlimited

########## GlusterFS ###########
alias pgl='ps auxww | grep gluster'
alias glusterd='glusterd -LDEBUG'

# Log and Vol file paths
export gfl=/usr/local/var/log/glusterfs
export gfv=/var/lib/glusterd/vols

# Add glusterd to PATH
addtopath /usr/local/sbin/
