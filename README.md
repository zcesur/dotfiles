#### `root@host:/#`
```sh
apt-get update && apt-get install -y git sudo zsh tmux vim
user='cesur'
adduser -s /bin/zsh -G sudo $user
# echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
```
#### `user@host:~$`
```sh
if [ ! -e "$HOME/tmp" ]; then
    git clone --recursive \
        --separate-git-dir="$HOME/tmp/.myconf" \
        https://github.com/zcesur/dotfiles.git "$HOME/tmp"
    find "$HOME/tmp" -mindepth 1 -maxdepth 1 -exec mv {} "$HOME" \;
    rm -r "$HOME/tmp"
    source ~/.zshrc
    cfg config status.showUntrackedFiles no
fi
```
