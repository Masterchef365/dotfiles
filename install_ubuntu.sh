#!/usr/bin/env bash

base() {
    sudo apt install compton curl fonts-fantasque-sans git hsetroot htop i3 python3-pip rofi stow
    git clone git@github.com:Masterchef365/dotfiles.git .dotfiles
    curl https://sh.rustup.rs -sSf | sh
    cargo install --git https://github.com/jwilm/alacritty.git
}

neovim_and_deps() {
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
    sudo pip3 install neovim pynvim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +'PlugInstall'

}

broccolibot_deps() {
    sudo apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE
    sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u
    sudo apt install libopencv-dev librealsense2-dev librealsense2-utils
}

base()
neovim_and_deps()
broccolibot_deps()
