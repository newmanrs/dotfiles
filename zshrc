export LC_ALL=en_US.UTF-8

# oh-my-zsh
   # ZSH=/usr/share/oh-my-zsh/
    #ZSH_THEME="agnoster-recolored"  #I modified agnoster slightly

    # Which plugins would you like to load?
    # Standard plugins can be found in $ZSH/plugins/
    # Custom plugins may be added to $ZSH_CUSTOM/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    #plugins=(git)

    #export EDITOR='vim'

    #ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
    #if [[ ! -d $ZSH_CACHE_DIR ]]; then
    #  mkdir $ZSH_CACHE_DIR
    #fi

    #source $ZSH/oh-my-zsh.sh

# disabling zsh autocd
    #unsetopt AUTO_CD

# pyenv python version manager
    export PATH=$HOME/.pyenv/bin:$PATH
    export PATH=$HOME/.pyenv/shims:$PATH

    eval "$(pyenv init -)"
    #eval "$(pyenv virtualenv-init -)"

# Rust (rustup)
    export PATH=$PATH:$HOME/.cargo/env

# tmux if not exist, attach/create session
    if [ -z $TMUX ]; then
        tmux new-session -A -s main
    fi

# WSL
    if $(uname -a | grep -iq Microsoft); then
        # echo "Microsoft in 'uname -a'"
        # VCXSRV for GUI
        export DISPLAY=$(
            grep -m 1 nameserver /etc/resolv.conf |
            awk '{print $2}'
            ):0
        export LIBGL_ALWAYS_INDIRECT=1

        # Source env vars for neo4j desktop
        source ~/.local/neo4j/local
    fi

# Python module help into vim
function pyhelp {
    if [ -z "$1" ]; then
        echo "provide module name as arg"
        return 0
    else
        # Pipe output of pythons help into vim with syntax
        # highlighting.  It seems to work best abusing language
        # files that do not match single quotations as strings.
        pydoc $1 | \
            vim -c 'set syntax=rust' -c '%s/\s\+$//e' -
    fi
}

# zsh shell builtin 'time' formatting string TIMEFMT
# see 'man zshparam'.  Note the manual says mem is
# given in kB, but at this time is MB on linux, kB
# # on osx.
export TIMEFMT=$'\ntime %J\n  %*E, (%E) total wallclock time\n  %U user mode cpu-core seconds\n  %S kernel mode cpu-core seconds\n  %P cpu-core percentage\n  %M max memory usage (mb)'

alias blog='cd ~/local/blog'
