#### `root@host:/#`
```sh
apt-get update && apt-get install -y git zsh tmux vim curl

user='cesur'
adduser --shell /bin/zsh $user
adduser $user sudo
```
#### `user@host:~$`
```sh
# Load dotfiles
tmp_dir="$(mktemp -d)"
dotfiles_url='https://github.com/zcesur/dotfiles.git'
pathogen_url='https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'

git clone --recursive --separate-git-dir="$tmp_dir/.myconf" "$dotfiles_url" "$tmp_dir"
find "$tmp_dir" -mindepth 1 -maxdepth 1 -exec mv {} "$HOME" \;
rm -r "$tmp_dir"

mkdir -p ~/.vim/autoload
curl -o ~/.vim/autoload/pathogen.vim "$pathogen_url"

source ~/.zshrc
cfg config status.showUntrackedFiles no
```

```sh
# Link systemd units
for unit in ~/etc/systemd/system/*.service; do
    sudo systemctl link "$unit"
done
```

```sh
# Link binaries
for bin in ~/bin/*; do
    sudo ln -s "$bin" "/usr/local/bin/$(basename "$bin")"
done
```
