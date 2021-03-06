#-------------------------#
# PATH                    #
#-------------------------#
export JAVA_HOME="/usr/local/jdk1.8.0_162"
export ANDROID_HOME="$HOME/Android/Sdk"
export GRADLE_HOME="/opt/gradle/gradle-6.1"
export GOPATH="$HOME/go"

export                          PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME/.npm-global" ]   && PATH="$PATH:$HOME/.npm-global/bin"
[ -d "$HOME/.cargo" ]        && PATH="$PATH:$HOME/.cargo/bin"
[ -d "$HOME/.cabal" ]        && PATH="$PATH:$HOME/.cabal/bin"
[ -d "/opt/cabal/3.0" ]      && PATH="$PATH:/opt/cabal/3.0/bin"
[ -d "/opt/ghc/7.4.1" ]      && PATH="$PATH:/opt/ghc/7.4.1/bin"
[ -d "/usr/local/cuda-9.1" ] && PATH="/usr/local/cuda-9.1/bin${PATH:+:${PATH}}"
[ -d "/usr/local/go" ]       && PATH="$PATH:/usr/local/go/bin"
[ -d "$GOPATH" ]             && PATH="$PATH:$GOPATH/bin"
[ -d "$JAVA_HOME" ]          && PATH="$PATH:$JAVA_HOME/bin"
[ -d "$ANDROID_HOME" ]       && PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
[ -d "$GRADLE_HOME" ]        && PATH="$PATH:$GRADLE_HOME/bin"

#-------------------------#
# APPLICATIONS            #
#-------------------------#
export EDITOR='vim'
export SYSTEMD_EDITOR="$(which vim)"
export SUDO_EDITOR='vim'
