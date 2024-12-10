# oh-my-zsh
#export SHELL=/bin/zsh
#export ZSH=$HOME/.oh-my-zsh
#export UPDATE_ZSH_DAYS=30
#ENABLE_CORRECTION="true"
#COMPLETION_WAITING_DOTS="true"
#HIST_STAMPS="yyyy-mm-dd"
#HISTSIZE=20000
#SAVEHIST=$HISTSIZE
#KEYTIMEOUT=1
#setopt hist_ignore_all_dups
#setopt hist_ignore_space



# Disable hostname completion. Fixing slow completion
#zstyle ':completion:*' hosts off
#
## Plugins
#case ${OSTYPE} in
#    darwin*)
#        plugins=(git pip brew macos)
#    ;;
#    linux*)
#        plugins=(git pip)
#    ;;
#esac
#source $ZSH/oh-my-zsh.sh

precmd () {
  echo -n -e "\a"
}  

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
        eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
    linux*)
        export PATH="/opt/Qt5.7.0/5.7/gcc_64/bin:$PATH"
        export PATH="/usr/local/cuda/bin:$PATH"
        export PATH="/snap/bin:$PATH"
        export TERM=xterm-256color
        alias tmux="TERM=tmux-256color tmux -2"
        export JAVA_HOME=/usr/lib/jvm/default-java
        alias ls='ls -GF --color=auto'

        if uname -r |grep -qi 'Microsoft' ; then
            echo "Windows subsystem for linux"
            export DOCKER_HOST=localhost:2375
            export DISPLAY=localhost:0.0
        else
            echo "Native Linux"
        fi
    ;;
    cygwin*)
        export CHERE_INVOKING=1
    ;;
esac

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/.bin:$PATH"
export EDITOR='vim'
export WORKON_HOME=$HOME/.virtualenvs

if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)"
fi

## prompt
#function get_pwd() {
#  echo "${PWD/$HOME/~}"
#}
#PROMPT='%{$fg[green]%}%n@%m %{$fg[blue]%}$(get_pwd) %{$reset_color%}$(git_prompt_info)
#$ %{$reset_color%}'
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[yellow]%}✔"


## vi mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

GPG_TTY=`tty`
export GPG_TTY
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

#if [[ $(hostname) =~ "^MacBook.*" ]]; then
#    base16_irblack
#elif [[ $(hostname) =~ "^DESKTOP.*" ]]; then
#    base16_irblack
#elif [ $(hostname) = "mato" ]; then
#    base16_dracula
#elif [ $(hostname) = "tiso" ]; then
#    base16_dracula
#elif [ $(hostname) = "knight" ]; then
#    base16_gruvbox-dark-pale
#else
#    base16_one-light
#fi

command_exist() {
    command -v "$1" >/dev/null 2>&1
}
if command_exist tinty; then
    tinty apply base16-dracula
fi

if whence dircolors >/dev/null; then
    [ -f ~/.dir_colors ] && eval "$(dircolors ~/.dir_colors)"
fi


# CUDA paths
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$CUDA_HOME/extras/CUPTI/lib64"
#export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
#export LD_LIBRARY_PATH="/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
#export LD_LIBRARY_PATH="$HOME/vcpkg/installed/x64-linux/lib/:$LD_LIBRARY_PATH"

# Aliases
command_exists () { type "$1" &> /dev/null ; }  # check a cammand availability
if command_exists nvim; then alias vim='nvim'; fi
if command_exists xdg-open; then alias open='xdg-open'; fi
if command_exists gshuc; then alias shuf='gshuf'; fi

alias vi='vim'
alias initconda='eval "$(/home/rick/miniconda3/bin/conda shell.zsh hook)"'

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.claude ] && source ~/.claude

CONDA_HOME=$HOME/mambaforge
if [ ! -d $CONDA_HOME ]; then
    CONDA_HOME=$HOME/miniconda3
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($CONDA_HOME'/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
export NODE_VIRTUAL_ENV_DISABLE_PROMPT=1
[ -f ~/nodeenv_base/bin/activate ] && source ~/nodeenv_base/bin/activate
# <<< conda initialize <<<

eval "$(starship init zsh)"

