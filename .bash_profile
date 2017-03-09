#!/usr/local/bin/bash
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
export nndk=$HOME/Library/Android/ndk
export ANDROID_NDK=$nndk
export PATH=$PATH:$nndk
# trying to add the google play services
export ngps=/Users/fmerzadyan/Library/Android/sdk/extras/google/m2repository/com/google/android/gms
export PATH=$PATH:$ngps

# gradle
export GRADLE_HOME=/usr/local/opt/gradle/libexec

# google apis
export GOOGLE_APIS=$nsdk/add-ons/addon-google_apis-google-23

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk.jdk/Contents/Home
setJavaVersion() {
	JAVA_HOME=$(/usr/libexec/java_home -v $1)
	if [[ $? -eq 0 ]]; then
		echo "successfully set JAVA_HOME as $JAVA_HOME"
	else
		echo "Reverting to default location"
		JAVA_HOME=$(/usr/libexec/java_home -verbose) || return
	fi
}

# node
setNodeVersion() {
	npm cache clean -f
	npm install -g n
	n $1
	echo "Node version: $(node -v). NPM version: $(npm -v)"
}

# ccache
export NDK_CCACHE=/usr/local/bin/ccache
export NUM_CPUS=8

# scala
export PATH=$PATH:$HOME/scala/bin

export GENYMOTION_HOME=/Applications/Genymotion.app/Contents/MacOS
export PATH=$PATH:$GENYMOTION_HOME

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
alias a="atom ."

# appcelerator titanium shortcuts
# use quotation marks when calling to expand string e.g. cd "$tsdk"
export tsdk="$HOME/Library/Application Support/Titanium"
# replace tidev variable here
export tidev=$HOME/workspace/timob
export tibuild=$tidev/build
export titest=$HOME/workspace/studio

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
alias u='cd $HOME/Documents/OneDrive/unispace && ls'
alias wt='cd $titest/test'
alias f='cd $HOME/forgespace && ls'
alias fv='cd $HOME/forgespace/vicinity'
alias d='cd $HOME/Documents'
alias dt='cd $HOME/Desktop'
alias dl='cd $HOME/Downloads'
alias ntest='cd $tidev/build && npm install && node scons.js test android'
alias wedit='cd $tidev && atom .'
alias ndev='appc run -p android -T device'
# requires GENYMOTION_HOME path set in PATH
alias gm='genymotion &'
alias nem='run_android_emulator'
alias iem='open -a Xcode && appc run -p ios'
# android adb restart
alias nr='adb kill-server && adb start-server'
alias np='android_push'

# stage all modified files but unstage .gitignore then show result
# would be good to see my alias/functions without visiting this file
# to remove all local branches but keep master:
# git branch | grep -v "master" | xargs git branch -D
alias gl='git_log'
alias gs='git status'
alias gd='git_diff'
alias ga='git_add'
alias gc='git_commit'
alias gp='git_push'
alias gum='git_update_master'
alias gnb='git_new_branch'
alias gdb='git_delete_branch'
alias gsl='git stash list'
alias gss='git_show_stash'
alias gsa='git_stash_apply'
alias gsd='git_stash_drop'
alias gr='git reset'
alias grh='git reset --hard'
alias pr='pull_request'

# reload .bash_profile after changes
# shellcheck disable=SC2139
alias rl="source ~/.bash_profile"
alias hc='history -cw && echo '' > $HOME/.bash_history'
alias wipe="clear && printf '\e[3J' && hc && rl"

alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias o='open .'

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
if [[ "$1" == "latest" || "$1" == "-l" || "$1" == "l" ]]; then
	filter=24
else
	filter=$1
fi
	# range of accepted answers: 17-25
	if [[ ( ! -z $filter ) && ( $filter =~ ^(1[7-9]|2[0-5])$ ) ]]; then
		case "$filter" in
			24 )
				appc run -p android -T emulator --device-id GN6P-24
				;;
			19 )
				appc run -p android -T emulator --device-id GN5-19
				;;
			* )
				echo "no avd has been created for that api level"
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

git_log() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git log --oneline -$1
}

git_diff() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git diff
}

git_add() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git add -u && git reset HEAD .gitignore && git reset HEAD android/dev/TitaniumTest/assets/Resources/app.js && git status
}

git_commit() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git commit -m "$1"
}

git_push() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git push $1 $2
}

git_update_master() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git stash && git checkout master && git pull upstream master && git push origin master -f
}

git_new_branch() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	if [[ ! -z $1 ]]; then
		git stash
		git checkout master
		git checkout -b "$1"
	fi
}

git_delete_branch() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	if [[ ! -z $1 ]]; then
		git checkout master
		git branch -D "$1"
	fi
}

git_show_stash() {
	# execute and redirect all output to /dev/null
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	# execute and redirect all output to /dev/null
	git stash show -p stash@{$1} &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ enter integer where 0 < i <= $(( $git_stash_list_length-1 ))"
	else
		# if execution had no errors then execute without redirect to /dev/null
		git stash show -p stash@{$1}
	fi
}

git_stash_apply() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git stash apply stash@{$1}
}

git_stash_drop() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git stash drop stash@{$1}
}

git_stash_list_length() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	list=$(git stash list -n 100 &> /dev/null)
	# strip tabs
	size=$(echo "$list" | wc -l | sed 's/^[ \t]*//')
	return $size
}

pull_request() {
	git rev-parse --show-toplevel &> /dev/null
	if [[ $? -ne 0 ]]; then
		echo "error ~ not git repo"
		return
	fi
	git stash save
	git checkout master
	# git fetch <remote_name> pull/<pr_id>/head:<branch_name>
	# e.g. git fetch upstream pull/8759/head:pivot
	# $1 is remote name, $2 is id of PR, $3 is branch name
	# make upstream default $1
	if [[ $# < 3 ]]; then
		echo "remote is not given; default upstream is used."
		$1='upstream'
		$2=$1
		$3=$2
	fi
	git fetch $1 pull/$2/head:$3
	git checkout $3
}

# this function requires jq; `brew install jq` to install jq
hook() {
	res=$HOME/setups/.hook_res.json
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

android_push() {
	# todo - improve this function
	# push file into Downloads folder in emulator
	adb push $1 /sdcard/Download/$2
}

libc++() {
	cp -r /Users/fmerzadyan/workspace/templates/android.runtime.v8.x86/* /Users/fmerzadyan/workspace/timob/android/runtime/v8/libs/x86
}

template_timob() {
	cp -r /Users/fmerzadyan/workspace/templates/titanium.src.java.com/frankify /Users/fmerzadyan/workspace/timob/android/titanium/src/java/com/
	touch /Users/fmerzadyan/workspace/timob/android/dev/TitaniumTest/assets/app.json
}
