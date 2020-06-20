# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/frankie.and.one/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    colored-man-pages
    web-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ANDROID_HOME=/Users/frankie.and.one/Library/Android/sdk
ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
ANDROID_NDK=/Users/frankie.and.one/Library/Android/sdk/ndk-bundle
# JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.0.1.jdk/Contents/Home

# export PATH=$ANDROID_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_NDK:$JAVA_HOME

# Need to specify /usr/local/bin in .zshrc because `brew` command is not recognised by zsh.
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$JAVA_HOME
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$ANDROID_HOME
export PATH=$PATH:$ANDROID_PLATFORM_TOOLS

# Mutliple Java environments management (jenv)
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# export PATH="/Users/frankie.and.one/anaconda3/bin/ac:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/frankie.and.one/anaconda3/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/frankie.and.one/anaconda3/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/frankie.and.one/anaconda3/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/frankie.and.one/anaconda3/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Removes duplicates from PATH variable when reloading (sourcing) .zshrc (this) file.
if [ -n "$PATH" ]; then
    old_PATH=$PATH:
    PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*} # the first remaining entry
        case $PATH: in
        *:"$x":*) ;;        # already there
        *) PATH=$PATH:$x ;; # not there yet
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi

alias rl='source ~/.zshrc'
alias ch='history -cw && echo '' > ~/.zsh_history'
alias wipe="clear && printf '\e[3J' && ch && rl"
alias ls='ls -a'
alias ll='ls -l'
alias lla='ls -al'
# External SSD drive
alias my_passport='cd /Volumes/My\ Passport'

# Shows last 10 git commits where each commit occupies only one line
# A paramater is optional - shows 10 by default otherwise uses the passed in arg
git_log() {
    if [ $# -eq 0 ]; then
        git log --oneline -10
    else
        git log --oneline -n $1
    fi
}

# Opens up the git configs directory - make sure to keep this updated and pointed to the correct directory
open_git_config() {
    # code ~/.ssh/config
    code ~/.ssh/
}

# Checks whether SSH agent is currently running
start_ssh_agent() {
    eval "$(ssh-agent -s)"
}

# Restarts the SSH agent used for things like Git access
restart_ssh_agent() {
    killall ssh-agent
    start_ssh_agent
    rl
}

# Adds tootoot_rsa (frankytootoot@tootoot.co.uk Github account keys) so you can can access
# Tootoot repos
add_ssh_to_keychain() {
    # ssh-add -K ~/.ssh/id_rsa
    ssh-add -K ~/.ssh/tootoot_rsa
    rl
}

# Requires you to be inside the project directoy, have coda installed and chosen as the python package manager for that
# Python project
php_conda_get_requirements_list() {
    conda list -e >requirements.txt
}

# Requires you to be inside the project directoy, have coda installed and chosen as the python package manager for that
# Python project - converts the conda requirements into something that pip understands
php_pipi_get_requirements_list() {
    pip install -r requirements.txt
}

# macOS may prevent mongod from running after installation. If you receive a security error when starting mongod indicating that the developer could not be identified or verified, do the following to grant mongod access to run:
# Open System Preferences
# Select the Security and Privacy pane.
# Under the General tab, click the button to the right of the message about mongod, labelled either Open Anyway or Allow
# Anyway depending on your version of macOS.
# To run MongoDB (i.e. the mongod process) as a macOS service, issue the following:
mongodb_start() {
    brew services start mongodb-community@4.2
}

# To stop a mongod running as a macOS service, use the following command as needed:
mongodb_stop() {
    brew services stop mongodb-community@4.2
}

# To run MongoDB (i.e. the mongod process) manually as a background process, issue the following:
# To stop a mongod running as a background process, connect to the mongod from the mongo shell, and issue the shutdown
# command as needed.
mongodb_start_manually() {
    mongod --config /usr/local/etc/mongod.conf --fork
}

# To verify that MongoDB is running, search for mongod in your running processes:
# You can also view the log file to see the current status of your mongod process:
# /usr/local/var/log/mongodb/mongo.log.
mongodb_is_running() {
    ps aux | grep -v grep | grep mongod
}

mongodb_shell() {
    mongo
}

alias using_new_rsa=GIT_SSH_COMMAND='ssh -i ~/.ssh/new_rsa'
# GIT_SSH_COMMAND='ssh -i ~/.ssh/new_rsa' git clone git@github.com:tootootltd/tootoot-android.git tootoot-edu

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
# brew install zsh-syntax-highlighting
# For zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
