export PATH=$PATH:~/.rvm/scripts/rvm
export PATH=$PATH:~/Library/Android/sdk/tools
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export ANDROID_SDK=~/Library/Android/sdk
export PATH=$PATH:~/Library/Android/android-ndk-r12b
export ANDROID_NDK=~/Library/Android/android-ndk-r12b
export PATH=$PATH:~/workspace
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:~/scala/bin
export GRADLE_HOME=$PATH

# export CLASSPATH=/Users/fmerzadyan/forgespace/CruiseControl/out/production/CruiseControl/com/merzadyan
export CLASSPATH=$CLASSPATH:/Users/fmerzadyan/lib/commons-lang3-3.5/commons-lang3-3.5.jar/

# alias compile="rm -fr /Users/fmerzadyan/forgespace/CruiseControl/out/production/CruiseControl/com/merzadyan/*.class && javac -d  /Users/fmerzadyan/forgespace/CruiseControl/out/production/CruiseControl/com/merzadyan /Users/fmerzadyan/forgespace/CruiseControl/src/com/merzadyan/*.java"
# alias run="cd /Users/fmerzadyan/forgespace/CruiseControl/src && java -cp : com/merzadyan/Main android emulator list"

# git auto completion scripts
source ~/.git-completion.bash
source ~/.git-prompt.sh

# sublime launcher
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
#set sublime as default editor
export EDITOR='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -w'
# visual code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$@";}  

#scons build, package and install
alias scons='cd /Users/fmerzadyan/workspace/titanium_mobile/build && node scons.js build && node scons.js package && node scons.js install'

alias prod='appc logout; appc config set defaultEnvironment production; APPC_ENV=production appc login'
alias preprod='appc logout; appc config set defaultEnvironment preproduction; APPC_ENV=preproduction appc login'
alias preprodprod='appc logout; appc config set defaultEnvironment preprodonprod; APPC_ENV=preprodonprod appc login'
# output ls in different colour
# export CLICOLOR=1
# export LSCOLORS=ExFxCxDxBxegedabagacad
alias ls='ls -FA'

# reload .bash_profile after changes
alias reload='. ~/.bash_profile'
alias hclean='history -cw && echo "" > ~/.bash_history'

# same bash history accross different terminals
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# FlatUI
export PS1='\[\e[00;31m\]\u\[\e[0m\]\[\e[00;35m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;35m\]:\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;34m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '

# Monokai
# export PS1='\[\e[00;37m\]\u\[\e[0m\]\[\e[00;31m\]@\[\e[0m\]\[\e[00;34m\]\h\[\e[0m\]\[\e[00;31m\]:\[\e[0m\]\[\e[00;32m\]\w\[\e[0m\]\[\e[00;33m\]$(__git_ps1 " (%s)")\[\e[0m\]\$ '
alias show='defaults write com.apple.finder AppleShowAllFiles -bool YES && killall Finder'
alias w='cd ~/workspace/titanium_mobile && ls'
alias t='cd /Users/fmerzadyan/Library/Application\ Support/Titanium && ls'
alias sw='cd /Users/fmerzadyan/Documents/Appcelerator_Studio_Workspace'
alias f='cd ~/forgespace && ls'
alias ntest='cd /Users/fmerzadyan/workspace/titanium_mobile/build && npm install && node scons.js cleanbuild && node scons.js test android'
alias wedit='cd /Users/fmerzadyan/workspace/titanium_mobile && atom .'
alias ndev='ti clean && appc run -p android -T device'
alias nem='run_android_emulator'
alias iem='open -a Xcode && appc run -p ios'

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
		echo -e "Usage example:  nem <api-level> e.g. 'nem 24'"
		echo -e "list of emulators:"
		echo -e
		vboxmanage list vms
		insert_star
	fi
}
# stage all modified files but unstage .gitignore then show result
alias git_add='git add -u && git reset HEAD .gitignore && git reset HEAD android/dev/TitaniumTest/assets/Resources/app.js && git status'
alias git_update='git stash && git checkout master && git pull upstream master && git push origin master'
alias git_new='git_new'

git_new() {
	if [[ ! -z $1 ]]; then
		#statements
		git stash
		git checkout master
		git checkout -b $1
	fi
}

alias git_peek='git_show_stash'

git_show_stash() {
	if [[ ! -z $1 ]]; then
		git stash list && git stash show -p stash@{$1}
	fi
}

# TODO allow history tracking like in finder for going forward
trek() {
	if [[ ! -z $1 ]]; then
		if [[ $1 -lt 0 ]]; then
			for (( i = 0; i < $(( $1 * -1 )); i++ )); do
				cd ..
			done
		fi
	fi
}

alias setup='cp $HOME/setups/.bash_profile $HOME/.bash_profile && reload'

# TODO instead of overwriting .bash_res.json file only change specific value for "hook" key
hook() {
	res="$HOME/.bash_res.json"
	if [[ ! -e $res ]]; then
		echo -e "$res does not exist so creating"
		touch "$res"
	fi
	# matches any case of pull or p
	if [[ $1 =~ ^[Pp]+[Uu]+[Ll]{2}|[Pp]$ ]]; then
		# hook is the key
		cd "$(cat "$res" | jq -r ".hook")"
	else
		dir=$(pwd)
		echo "{ \"hook\" : \"${dir}\" }" > $res
	fi
}

# command line project shortcut
cc() {
	project="/Users/fmerzadyan/forgespace/CruiseControl"
	if [[ ! -d $project ]]; then
		return
	fi
	if [[ $# -ge 3 ]]; then
		cd $project
		gradle run -Pin=$1/$2/$3
	fi
}