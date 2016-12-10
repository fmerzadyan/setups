#!/usr/bin/env bash
# general development paths
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/sbin:/usr/bin:/sbin
export PATH=$PATH:$HOME
export PATH=$PATH:$HOME/workspace

export PATH=$PATH:$HOME/.rvm/scripts/rvm

# android sdk
export nsdk=$HOME/Library/Android/sdk
# SDK looks for ANDROID_SDK/NDK in PATH
export ANDROID_SDK=$nsdk
export PATH=$PATH:$nsdk/tools
export PATH=$PATH:$nsdk/platform-tools
export ANDROID_PLATFORM=$nsdk/platforms/android-23

# android ndk
export nndk=$HOME/Library/Android/android-ndk-r12b
export ANDROID_NDK=$nndk
export PATH=$PATH:$nndk

# google apis
export GOOGLE_APIS=$nsdk/add-ons/addon-google_apis-google-23

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home
setJavaVersion() {
	JAVA_HOME=$(/usr/libexec/java_home -v $1)
	if [[ $? -eq 0 ]]; then
		echo "successfully set JAVA_HOME as $JAVA_HOME"
	else
		echo "Reverting to default location"
		JAVA_HOME=$(/usr/libexec/java_home -verbose) || return
	fi
}

# ccache
export NDK_CCACHE=/usr/local/bin/ccache
export NUM_CPUS=8

# scala
export PATH=$PATH:$HOME/scala/bin

# git auto completion scripts
# shellcheck source=/Users/fmerzadyan/setups/.git-completion.bash
source $HOME/setups/.git-completion.bash
# shellcheck source=/Users/fmerzadyan/setups/.git-prompt.sh
source $HOME/setups/.git-prompt.sh

# application/program shortcuts
# sublime launcher
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
#set sublime as default editor
export EDITOR="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -w"
# visual code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$@";}

# appcelerator titanium shortcuts
# use quotation marks when calling to expand string e.g. cd "$tsdk"
export tsdk="$HOME/Library/Application Support/Titanium"
export tidev=$HOME/workspace/new_titanium_mobile
export tibuild=$tidev/build

alias t='cd "$tsdk" && ls'
# scons build_jsca=0  # Do full build & packaging but omit JSCA generation 
alias sconsself='scons build_jsca=0'
alias sconsb='node "$tibuild"/scons.js build'
alias sconsp='node "$tibuild"/scons.js package'
alias sconsi='node "$tibuild"/scons.js install'
alias scons='sconsb && sconsp && sconsi'
alias prod='appc logout; appc config set defaultEnvironment production; APPC_ENV=production appc login'
alias preprod='appc logout; appc config set defaultEnvironment preproduction; APPC_ENV=preproduction appc login'
alias preprodprod='appc logout; appc config set defaultEnvironment preprodonprod; APPC_ENV=preprodonprod appc login'

# development shortcuts
alias setups='cd $HOME/setups'
alias show='defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder'
alias w='cd $tidev && ls'
alias st='cd $HOME/Documents/Appcelerator_Studio_Workspace/test'
alias f='cd $HOME/forgespace && ls'
alias dt='cd $HOME/Desktop'
alias dl='cd $HOME/Downloads'
alias ntest='cd $tidev/build && npm install && node scons.js test android'
alias wedit='cd $tidev && atom .'
alias ndev='appc run -p android -T device'
alias nem='run_android_emulator'
alias iem='open -a Xcode && appc run -p ios'

# stage all modified files but unstage .gitignore then show result
alias git_add='git add -u && git reset HEAD .gitignore && git reset HEAD android/dev/TitaniumTest/assets/Resources/app.js && git status'
alias git_update='git stash && git checkout master && git pull upstream master && git push origin master'
alias git_new='git_new'
alias git_peek='git_show_stash'

# reload .bash_profile after changes
# shellcheck disable=SC2139
alias rl="source ~/.bash_profile"
alias hclean='history -cw && echo '' > $HOME/.bash_history'

alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'

# same bash history accross different terminals
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don"t overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Themes
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# FlatUI theme
# export PS1='\[\e[00;31m\]\u\[\e[0m\]\[\e[00;35m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;35m\]:\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;34m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

# u - the current user's username
# h - the current machine's hostname
# j - the number of jobs managed by this shell
# @ - the current time (12 hour format)
# d - the current date
# w - path of the current working directory
# W - just the current working directory
# e - an ASCII escape character (033)
# n - adds a newline character
#
# normal='\[\e[0m\]'
# green='\[\033[0;92m\]'
# blue='\[\033[0;94m\]'
# yellow='\[\033[0;93m\]'
# changed from using variables because of issues with globular expansions/substitutions

dynamic_theme() {
	if [[ $PWD != "$HOME" ]]; then
		export PS1='\[\033[0;91m\]\w\[\033[0;31m\] $(__git_ps1 "~ %s") \[\033[1;94m\]\$ \[\033[0;92m\]'
	else
		export PS1='\[\033[0;31m\] $(__git_ps1 "~ %s") \[\033[1;94m\]\$ \[\033[0;92m\]'
	fi
}

# invoke function after every terminal command input
PROMPT_COMMAND=dynamic_theme
# set max number of working directory parts
PROMPT_DIRTRIM=2
# autocomplete cycling
bind TAB:menu-complete

alias ls='ls -FA'

# custom functions
insert_star() {
	echo -e
	for (( i = 0; i < $(tput cols); i++ )); do
			if [ $((i%2)) -eq 0 ]; then
				printf "*"
			else
				printf " "
			fi
	done
	echo -e
}

run_android_emulator() {
	if [[ ( ! -z $1 ) && ( $1 =~ ^(1[7-9]|2[0-4])$ ) ]]; then
		case "$1" in
			24 )
				ti clean && appc run -p android -T emulator --device-id 6P-API-24
				;;
			23 )
				ti clean && appc run -p android -T emulator --device-id S6-API-23
				;;
			22 )
				ti clean && appc run -p android -T emulator --device-id S6-API-22
				;;
			21 )
				ti clean && appc run -p android -T emulator --device-id S6-API-21-5.0.0
				;;
			19 )
				ti clean && appc run -p android -T emulator --device-id S5-API-19
				;;
			18 )
				ti clean && appc run -p android -T emulator --device-id Xperia-Z-API-18
				;;
			17 )
				ti clean && appc run -p android -T emulator --device-id Xperia-Z-API-17
				;;
		esac
	else
		insert_star
		# shellcheck disable=SC2016
		echo -e 'Usage example:  nem <api-level> e.g. `nem 24`'
		echo -e 'list of emulators:'
		echo -e
		vboxmanage list vms
		insert_star
	fi
}

git_new() {
	if [[ ! -z $1 ]]; then
		git stash
		git checkout master
		git checkout -b "$1"
	fi
}

git_show_stash() {
	if [[ ! -z $1 ]]; then
		"git stash list && git stash show -p stash@{$1}"
	fi
}

# TODO instead of overwriting .bash_res.json file only change specific value for "hook" key
hook() {
	res=$HOME/.bash_res.json
	if [[ ! -e $res ]]; then
		echo -e "$res does not exist so creating"
		touch "$res"
	fi
	# matches any case of pull or p
	if [[ $1 =~ ^[Pp]+[Uu]+[Ll]{2}|[Pp]$ ]]; then
		# shellcheck disable=SC2002
		# hook is the key 
		cd "$(cat "$res" | jq -r ".hook")" || return
	else
		dir=$(pwd)
		echo "{ \"hook\" : \"${dir}\" }" > "$res"
	fi
}

# command line project shortcut
cc() {
	project=$HOME/forgespace/CruiseControl
	if [[ ! -d $project ]]; then
		return
	fi
	if [[ $# -ge 3 ]]; then
		cd "$project" || return
		gradle run -Pin="$1/$2/$3"
	fi
}

# some lines for when coworkers gets too roudy
v() {
	case "$1" in
		1 )
			say -v Tessa -f "$HOME/setups/rough_1.txt" &
			;;
		2 )
			say -v Tessa -f "$HOME/setups/yomama_1.txt" &
			;;
		3 )
			say -v Tessa -f "$HOME/setups/yomama_2.txt" &
			;;
		* )
			;;
	esac
}