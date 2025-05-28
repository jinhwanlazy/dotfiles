# OS specific settings
case ${OSTYPE} in
    darwin*)
        export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin:/usr/local/sbin:/usr/local/texlive/2017/bin/x86_64-darwin"
        export PATH="/usr/local/opt/qt@5.7/bin:$PATH"
        # export TERM="screen-256color"
        # alias tmux="TERM=screen-256color tmux"
        export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
        export PATH="$HOME/Workspace/depot_tools:$PATH"
        # export TERM=xterm-256color
        # alias tmux="TERM=tmux-256color tmux -2"
        export XML_CATALOG_FILES=/usr/local/etc/xml/catalog
        export GPG_TTY=$(tty)
        eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
    linux*)
        export PATH="/opt/Qt5.7.0/5.7/gcc_64/bin:$PATH"
        export PATH="/usr/local/cuda/bin:$PATH"
        export PATH="/snap/bin:$PATH"
        export TERM=xterm-256color
        alias tmux="TERM=tmux-256color tmux -2"
        export JAVA_HOME=/usr/lib/jvm/default-java
        alias ls='ls --color=auto'

        if uname -r |grep -qi 'Microsoft' ; then
            #echo "Windows subsystem for linux"
            export DOCKER_HOST=localhost:2375
            export DISPLAY=localhost:0.0
        else
            #echo "Native Linux"
        fi
    ;;
    cygwin*)
        export CHERE_INVOKING=1
    ;;
esac

# Enable p10k  instant-prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit -u
setopt CASE_GLOB
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt INC_APPEND_HISTORY
setopt COMPLETE_IN_WORD




export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/.bin:$PATH"
export EDITOR='vim'
#export WORKON_HOME=$HOME/.virtualenvs

#if [ -z "$SSH_AUTH_SOCK" ]; then
#   eval "$(ssh-agent -s)"
#fi

## vi mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# GPG
GPG_TTY=`tty`
export GPG_TTY
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# CUDA paths
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$CUDA_HOME/extras/CUPTI/lib64"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Aliases
if command_exists nvim; then alias vim='nvim'; fi
if command_exists xdg-open; then alias open='xdg-open'; fi
if command_exists gshuc; then alias shuf='gshuf'; fi
if command_exists vim; then alias vi='vim'; fi

# App settings
if command_exists tinty; then 
    if [[ $(hostname) =~ "^MacBook.*" ]]; then
        tinty apply base16-irblack; 
    else
        tinty apply base16-dracula; 
    fi
fi
if command_exists dircolors; then eval "$(dircolors)"; fi
if command_exists fd; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
export PATH="${HOME}/.fzf/bin:${PATH}"
source <(fzf --zsh)

[ -f ~/.env ] && source ~/.env



# Conda
CONDA_HOME=$HOME/miniforge
if [ ! -d $CONDA_HOME ]; then
    CONDA_HOME=$HOME/miniforge3
fi
if [ ! -d $CONDA_HOME ]; then
    CONDA_HOME=$HOME/miniconda3
fi
if [ -d $CONDA_HOME ]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$CONDA_HOME/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$CONDA_HOME/etc/profile.d/conda.sh" ]; then
        . "$CONDA_HOME/etc/profile.d/conda.sh"
    else
        export PATH="$CONDA_HOME/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$CONDA_HOME/etc/profile.d/mamba.sh" ]; then
    . "$CONDA_HOME/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
fi


# Start P10k
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
