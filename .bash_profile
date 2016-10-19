# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:~/.rvm/scripts/rvm
export PATH=$PATH:~/Library/Android/sdk/tools
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export ANDROID_SDK=~/Library/Android/sdk
export PATH=$PATH:~/Library/Android/android-ndk-r12b
export ANDROID_NDK=~/Library/Android/android-ndk-r12b
export PATH=$PATH:~/workspace
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/scala/bin

# git auto completion scripts
source ~/.git-completion.bash
source ~/.git-prompt.sh

#sublime launcher
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
#set sublime as default editor
export EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -w'

#scons build, package and install
alias sconsall='node scons.js build && node scons.js package && node scons.js install'

alias toprod='appc logout; appc config set defaultEnvironment production; APPC_ENV=production appc login'
alias topreprod='appc logout; appc config set defaultEnvironment preproduction; APPC_ENV=preproduction appc login'
alias topreprodProd='appc logout; appc config set defaultEnvironment preprodonprod; APPC_ENV=preprodonprod appc login'
# output ls in different colour
# export CLICOLOR=1
# export LSCOLORS=ExFxCxDxBxegedabagacad
alias ls='ls -FA'

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# FlatUI
export PS1='\[\e[00;31m\]\u\[\e[0m\]\[\e[00;35m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;35m\]:\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;34m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

# Monokai
# export PS1='\[\e[00;37m\]\u\[\e[0m\]\[\e[00;31m\]@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;31m\]:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;33m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

# hide all files that start with .
function hide () {
	defaults write com.apple.finder AppleShowAllFiles -bool NO
    killall Finder
}

# show all files
function show () {
	defaults write com.apple.finder AppleShowAllFiles -bool YES
    killall Finder
}

function work () {
	cd ~/workspace
	ls
}

function play () {
	cd ~/forgespace
	ls
}
