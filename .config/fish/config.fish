if status is-interactive && type -q tmux && not set -q TMUX
    exec tmux -2 attach
end

alias cfg "git --git-dir=$HOME/.myconf/ --work-tree=$HOME"

set -x LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/local/lib"
set -x GOOGLE_APPLICATION_CREDENTIALS "$GOPATH/src/algora/deployment/firebase-admin-sdk.json"

if test -f '/usr/local/google-cloud-sdk/path.fish.inc'; source '/usr/local/google-cloud-sdk/path.fish.inc'; end
