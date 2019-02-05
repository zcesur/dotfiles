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
exists tmux && [[ -z $TMUX ]] && exec tmux -2 attach

#-------------------------#
# PATH                    #
#-------------------------#
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/path.zsh.inc'; fi
if [ -e '/home/cesur/.nix-profile/etc/profile.d/nix.sh' ]; then source '/home/cesur/.nix-profile/etc/profile.d/nix.sh'; fi
if [ -e '/home/cesur/anaconda2/etc/profile.d/conda.sh' ]; then source '/home/cesur/anaconda2/etc/profile.d/conda.sh'; fi
fpath=("$HOME/.zfunctions" $fpath)

#-------------------------#
# ALIASES                 #
#-------------------------#
alias ls='ls --color=auto'
alias tree='tree -C'
alias grep='grep --color'
alias 2pdf='wkhtmltopdf -g --disable-javascript --no-background'
alias k='kubectl'
alias cfg='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

#-------------------------#
# FUNCTIONS               #
#-------------------------#
fix_audio() {
    rm -r ~/.config/pulse/*
    rm -r ~/.pulse
    pulseaudio -k
}

mv_untracked() {
    if [ $# -eq 0 ]; then
        echo "Missing file operand"
        return 1
    fi
    mkdir -p "$1"

    git ls-files -z --others --exclude-standard | xargs -0 mv -nt "$1"
}

fnd() {
    local dir='/home/cesur/proj/Algora/main'
    find $dir $dir/algora/ $dir/js/ $dir/templates/ \
        -maxdepth 1 \
        -type f \
        -exec grep --color -InH "$1" {} \;
}

find_nonascii() {
    local dir=$([ $# -eq 0 ] && echo '.' || echo "$1")
    LC_ALL=C find "$dir" -name '*[! -~]*'
}

ls_hex() {
    local dir=$([ $# -eq 0 ] && echo '.' || echo "$1")
    find "$dir" \
        -maxdepth 1 \
        -exec sh -c \
        'printf "%-10s %s\n" "$1" "$(printf "$1" | xxd -pu )"' None {} \;
}

rm_symlink() {
    [ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

mk_logo() {
    local size=$1
    local input=$2
    local output=$3
    convert "$input" -thumbnail "$size>" \
        -gravity center \
        -background transparent \
        -extent "$size" \
        "$output"
}

#-------------------------#
# SHELL - COMPLETION      #
#-------------------------#
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then source '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi
exists kubectl && source <(kubectl completion zsh)

#-------------------------#
# SHELL - PROMPT          #
#-------------------------#
autoload -U promptinit
promptinit
prompt pure
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL='$'

#-------------------------#
# SHELL - HIGHLIGHTING    #
#-------------------------#
if [ -e '/home/cesur/.plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then source '/home/cesur/.plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'; fi
ZSH_HIGHLIGHT_STYLES[path]=
zle_highlight+=(paste:none)
