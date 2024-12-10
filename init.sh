#!/usr/bin/env bash

command_exist() {
    command -v "$1" >/dev/null 2>&1
}

install() {
    local src_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dst_dir="$HOME"
    local bak_dir="$src_dir/backup"

    mkdir -p "$HOME/$(dirname $1)"
    mkdir -p "$bak_dir/$(dirname $1)"

    # Check if source exists
    if [[ ! -e $src_dir/$1 ]]; then
        echo "Error: Source file or directory $src_dir/$1 does not exist"
        return 1
    fi

    # If target already exists, backup
    if [ -e "$dst_dir/$1" ]; then
        if [ -L "$dst_dir/$1" ]; then
            echo "Already installed: $dst_dir/$1 -> $(readlink $dst_dir/$1)"
            return 1
        else
            echo "Backing up $dst_dir/$1 -> $bak_dir/$1"
            mv "$dst_dir/$1" "$bak_dir/${1}"
        fi
    fi

    # Create symlink
    echo "Installing $src_dir/$1 -> $dst_dir/$1"
    ln -s "$src_dir/$1" "$dst_dir/$1"
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create symlink for $1"
        return 1
    fi
}

echo "USER: " $USER
echo "SHELL: " $SHELL
echo "OSTYPE: " $OSTYPE

# use zsh 
if [[ ! $SHELL =~ "zsh" ]]; then
    echo "changing shell"
    sudo usermod --shell /usr/bin/zsh $USER
    echo "login again and relaunch the script!"
    exit 1
fi

# install miniconda
if [ ! -d ~/miniconda3 ]; then
    mkdir -p ~/miniconda3
    case ${OSTYPE} in
        darwin*) curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh ;;
        linux*) wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh ;;
    esac
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm ~/miniconda3/miniconda.sh
fi

# install rust
if ! command_exist cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi

# cargo install starship --locked
if ! command_exist starship; then
    cargo install starship --locked
fi

## install tinty
if ! command_exist tinty; then
    cargo install tinty
    tinty sync
fi

install .config/nvim
install .zshrc
install .gitconfig
