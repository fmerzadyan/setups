#!/usr/bin/env bash

ANDROID_HOME=/Users/frankie.and.one/Library/Android/sdk
ANDROID_NDK=/Users/frankie.and.one/Library/Android/sdk/ndk-bundle

export PATH=$PATH:$ANDROID_HOME:/$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_NDK
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

source ~/dev/Setups/.git-completion.bash
source ~/dev/Setups/.git-prompt.sh

alias rl='source ~/.bash_profile'
alias ch='history -cw && echo '' > ~/.bash_history'
alias wipe="clear && printf '\e[3J' && ch && rl"
alias ls='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias my_passport='cd /Volumes/My\ Passport'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export TERM="xterm-256color"
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1='\[\e[0;33m\]\u\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\[\033[32m\]$(parse_git_branch)\[\033[00m\]$ '
export GREP_OPTIONS='--color=auto'

adb_reset() {
    adb kill-server
    adb start-server
}

adb_reset_with_wear() {
    adb_reset
    wear_connect_via_wifi
}

# IP address of wear can be found in developer settings (debug over WiFi).
wear_ip_address="192.168.1.91:5555"

wear_connect_via_wifi() {
    adb connect $wear_ip_address
}

git_log() {
    if [ $# -eq 0 ]; then
        git log --oneline -10
    else
        git log --oneline -n $1
    fi
}

git_find_conflicts() {
    git diff --name-only --diff-filter=U
}

git_merge_tutorial() {
    # git checkout master
    # git pull origin master
    # git checkout other-branch
    # git pull origin other-branch
    # git rebase -i master
    # git checkout master
    # git merge other-branch
    echo "git_merge_tutorial()"
}

# $1 - file path.
git_log_follow() {
    git log --follow -p -- $1
}

adb_screenshot() {
    adb exec-out screencap -p > screenshot.png
}

# $1 - file path.
# $2 - filename with extension.
adb_push() {
    adb push $1 /sdcard/0/$2
}