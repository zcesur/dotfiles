#-------------------------#
# PATH                    #
#-------------------------#
export JAVA_HOME="/usr/local/jdk1.8.0_162"
export ANDROID_HOME="$HOME/Android/Sdk"
export GOPATH="$HOME/go"
export LD_LIBRARY_PATH="/usr/local/cuda-9.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
export                          PATH="$PATH:$HOME/bin:$HOME/.local/bin"
[ -d "/.npm-global" ]        && PATH="$PATH:~/.npm-global/bin"
[ -d "/.cargo" ]             && PATH="$PATH:$HOME/.cargo/bin"
[ -d "$HOME/anaconda2" ]     && PATH="$PATH:$HOME/anaconda2/bin"
[ -d "$HOME/.cabal" ]        && PATH="$PATH:$HOME/.cabal/bin"
[ -d "/opt/cabal/1.22" ]     && PATH="$PATH:/opt/cabal/1.22/bin"
[ -d "/opt/ghc/7.10.3" ]     && PATH="$PATH:/opt/ghc/7.10.3/bin"
[ -d "/usr/local/cuda-9.1" ] && PATH="/usr/local/cuda-9.1/bin${PATH:+:${PATH}}"
[ -d "/usr/local/go" ]       && PATH="$PATH:/usr/local/go/bin"
[ -d "$GOPATH" ]             && PATH="$PATH:$GOPATH/bin"
[ -d "$JAVA_HOME" ]          && PATH="$PATH:$JAVA_HOME/bin"
[ -d "$ANDROID_HOME" ]       && PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

#-------------------------#
# APPLICATIONS            #
#-------------------------#
export EDITOR='vim'

#-------------------------#
# CREDENTIALS             #
#-------------------------#
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/proj/cloud-client/key.json"
