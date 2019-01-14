#-------------------------#
# UTILITY                 #
#-------------------------#
exists() {
    test -x "$(command -v "$1")"
}

#-------------------------#
# SHELL - OPTIONS         #
#-------------------------#
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob

#-------------------------#
# SHELL - CONTROLS        #
#-------------------------#
# Vi-style controls
bindkey -v
# Allow v to edit the command line
zle -N edit-command-line
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line
# Enable backspace
bindkey '^?' backward-delete-char
export KEYTIMEOUT=1
# Search through the history for lines beginning with the content in the buffer
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward

#-------------------------#
# TMUX                    #
#-------------------------#
exists tmux && [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -2 attach

#-------------------------#
# PATH                    #
#-------------------------#
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/path.zsh.inc'; fi
if [ -e '/home/cesur/.nix-profile/etc/profile.d/nix.sh' ]; then source '/home/cesur/.nix-profile/etc/profile.d/nix.sh'; fi
if [ -e '/home/cesur/anaconda2/etc/profile.d/conda.sh' ]; then source '/home/cesur/anaconda2/etc/profile.d/conda.sh'; fi

#-------------------------#
# ALIASES                 #
#-------------------------#
alias ls='ls --color=auto'
alias fix_audio='killall pulseaudio; rm -r ~/.config/pulse/*; rm -r ~/.pulse; pulseaudio -k*'
alias 2pdf='wkhtmltopdf -g --disable-javascript --no-background'
alias k='kubectl'
alias cfg='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
# cfg config status.showUntrackedFiles no

#-------------------------#
# FUNCTIONS               #
#-------------------------#
mv_untracked() {
    if [ $# -eq 0 ]; then
        echo "Missing file operand"
        exit 1
    fi

    IFS=$'\n'
    for file in $(git ls-files --others --exclude-standard)
    do
        mkdir -p $1
        mv $file $1
    done
    unset IFS
}

update_submodules() {
    cd ~
    for i in $(ls -d .plugins/*)
    do
        if [ -d "$i"/.git ]; then
            git submodule add $(cd $i && git remote show origin | grep Fetch | awk '{print $3}') ./$i
        fi
    done
}

fnd() {
    dir='/home/cesur/proj/Algora/main'
    find $dir $dir/algora/ $dir/js/ $dir/templates/ \
        -maxdepth 1 \
        -type f \
        -exec grep --color -InH "$1" {} \;
}

ls_nonascii() {
    dir=$([ $# -eq 0 ] && echo '.' || echo "$1")
    LC_ALL=C find "$dir" -name '*[! -~]*'
}

ls_hex() {
    dir=$([ $# -eq 0 ] && echo '.' || echo "$1")
    find "$dir" -maxdepth 1 -type f -exec sh -c 'printf "%-10s %s\n" "$1" "$(printf "$1" | xxd -pu )"' None {} \;
}

rm_symlink() {
    [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

#-------------------------#
# SHELL - COMPLETION      #
#-------------------------#
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi
exists kubectl && source <(kubectl completion zsh)

#-------------------------#
# SHELL - PROMPT          #
#-------------------------#
fpath=( "$HOME/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt pure
PURE_GIT_PULL=0

#-----------------------------#
# SHELL - SYNTAX HIGHLIGHTING #
#-----------------------------#
if [ -e '/home/cesur/.plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then source '/home/cesur/.plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'; fi
ZSH_HIGHLIGHT_STYLES[path]=
zle_highlight+=(paste:none)
