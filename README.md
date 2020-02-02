#### `root@host:/#`
```sh
apt-add-repository ppa:fish-shell/release-3
apt-get update
apt-get install -y git fish tmux vim curl ufw

user='cesur'
adduser --shell /usr/bin/fish $user
adduser $user sudo

ufw allow 22/tcp
ufw enable
```
#### `user@host:~$`
```fish
# Load dotfiles
set -l tmp_dir (mktemp -d)
set -l dotfiles_url 'https://github.com/zcesur/dotfiles.git'
set -l pathogen_url 'https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'

git clone --recursive --separate-git-dir="$tmp_dir"/.myconf $dotfiles_url $tmp_dir
find $tmp_dir -mindepth 1 -maxdepth 1 -exec mv {} $HOME \;
rm -r $tmp_dir

mkdir -p ~/.vim/autoload
curl -o ~/.vim/autoload/pathogen.vim $pathogen_url

source ~/.config/fish/config.fish
cfg config status.showUntrackedFiles no
```

```fish
# Link systemd units
for unit in ~/etc/systemd/system/*.service
    sudo systemctl link $unit
end
```

```fish
# Link binaries
for bin in ~/bin/*
    sudo ln -s $bin /usr/local/bin/(basename $bin)
end
```
