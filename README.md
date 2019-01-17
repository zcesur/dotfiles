#### `root@host:/#`
```sh
apt-get update && apt-get install -y git sudo zsh tmux vim
user='cesur'
adduser -s /bin/zsh -G sudo $user
# echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```
#### `user@host:~$`
```sh
git clone --recursive --separate-git-dir="$HOME/.myconf" https://github.com/zcesur/dotfiles.git "$HOME"
source ~/.zshrc
cfg config status.showUntrackedFiles no
```
