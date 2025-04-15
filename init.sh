#!/usr/bin/env bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install() {
    local src_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dst_dir="$HOME"
    local bak_dir="$src_dir/backup"

    mkdir -p "$HOME/$(dirname $1)"
    mkdir -p "$bak_dir/$(dirname $1)"

    # Check if source existss
    if [[ ! -e $src_dir/$1 ]]; then
        echo "Error: Source file or directory $src_dir/$1 does not exists"
        return 1
    fi

    # If target already existss, backup
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

case ${OSTYPE} in
    darwin*) ;;
        brew install tmux reattach-to-user-namespace
    linux*) 
        sudo add-apt-repository ppa:git-core/ppa
        sudo apt update
        sudo apt install -y git
        sudo apt install -y zsh tmux
        ;;
esac

# use zsh 
if [[ ! $SHELL =~ "zsh" ]]; then
    echo "changing shell"
    sudo usermod --shell /usr/bin/zsh $USER
    echo "login again and relaunch the script!"
    exit 1
fi


# install p10k
if [[ ! -d ~/powerlevel10k ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
fi

# install rust
if ! command_exists cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
fi

# install rust packages
cargo install fd-find
cargo install tinty

# install conda
if [ ! -d ~/miniforge ] && ! command_exists conda; then
    mkdir -p ~/miniforge
    #case ${OSTYPE} in
    #    darwin*) curl https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh -o ~/miniforge3/miniforge.sh ;;
    #    linux*) wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O ~/miniforge3/miniforge.sh ;;
    #esac
    #bash ~/miniforge3/miniforge.sh -b -u -p ~/miniforge3
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    bash Miniforge3-$(uname)-$(uname -m).sh -u -p ~/miniforge
fi

# install python packages
conda install python=3.10
conda install neovim pynvim nodejs=18.20.4

# install fzf
if [[ ! -d $HOME/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
git -C ~/.fzf pull
~/.fzf/install --all

# configs
tinty sync
conda config --set auto_activate_base True
conda config --set changeps1 False

install .config/nvim
install .zshrc
install .p10k.zsh
install .gitconfig
