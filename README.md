```
# Assumes you have a working Arch Linux system with pacaur(8) installed
git clone https://github.com/Masterchef365/dotfiles.git
cd dotfiles
pacaur -S - < install_list.txt
stow */ 
sudo cp wakelock.service /etc/systemd/system/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +'PlugInstall' +':q'
```
