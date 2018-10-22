sudo update-grub
sudo apt-add-repository universe
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt upgrade

sudo apt install i3-wm firefox gcc stow xinit cmake libfreetype6-dev libfontconfig1-dev xclip neovim ubuntu-drivers-common fonts-fantasque-sans compton rofi x11-xserver-utils
sudo ubuntu-drivers autoinstall

git clone https://github.com/masterchef365/dotfiles.git
rm .bashrc .bash_logout 
pushd dotfiles
stow */
popd

curl https://sh.rustup.rs -sSf | sh
source .cargo/env 
cargo install --git https://github.com/jwilm/alacritty.git

reboot

