# GCE's zshrc Modified 2018-11-16
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

echo "Sourcing Z shell... please wait...\n"
fpath=(/usr/local/share/zsh-completions $fpath)

# Path to your oh-my-zsh installation.
export ZSH="/Users/gce/.oh-my-zsh"
export PATH="/usr/local/opt/icu4c/bin:$PATH"

echo -n "Loading theme..."
# Load theme. See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
sleep 1
echo "done!"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# GCE -> I am not wise, at all. So my iterm takes forever to source. Not sorry.
plugins=(brew git iterm2 osx composer)

# source $ZSH/oh-my-zsh.sh

echo -n "Checking zplug packages..."
# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

# Clear packages
zplug clear

###########################################################
# Packages

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "momo-lab/zsh-abbrev-alias"
zplug "rawkode/zsh-docker-run"
zplug "arzzen/calc.plugin.zsh"
zplug "peterhurford/up.zsh"
zplug "jimeh/zsh-peco-history"

###########################################################
# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
else
    sleep 1
    echo "done!"
fi

echo -n "Loading plugins (please be patient; this might take a while)..."
zplug load

# Essential
source ~/.zplug/init.zsh

echo "done!"

# User configuration
echo -n "Configuring theme..."

export DEFAULT_USER="$USER"

POWERLEVEL9K_MODE='awesome-patched'

# START --> GCE
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

    POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
    POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
    POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
    POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''

    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" %n > "

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir dir_writable_joined)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time vcs background_jobs_joined time)
    POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"

    POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
    POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
    POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
    POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="white"

    POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
    POWERLEVEL9K_DIR_HOME_FOREGROUND="014"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="014"
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
    POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="014"
    POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
    POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
    POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
    POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
    POWERLEVEL9K_STATUS_VERBOSE=false
    POWERLEVEL9K_TIME_BACKGROUND="clear"
    POWERLEVEL9K_TIME_FOREGROUND="120"
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'
    POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
    POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'

    # POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"

    POWERLEVEL9K_HOME_ICON=''
    POWERLEVEL9K_HOME_SUB_ICON=''
    POWERLEVEL9K_FOLDER_ICON=''
    POWERLEVEL9K_ETC_ICON=''

    POWERLEVEL9K_CONTEXT_TEMPLATE="%n@`hostname -f`"
# END   --> GCE

sleep 1
echo "done!"

echo -n "Sourcing oh-my-zsh..."

# soure oh-my-zsh config
source $ZSH/oh-my-zsh.sh

sleep 1
echo "done!"

zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{yellow}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
                local color='%F{yellow}'

                [[ $speed -gt 100 ]] && color='%F{green}'
                [[ $speed -lt 50 ]] && color='%F{red}'

                echo -n "%{$color%} $ssid $speed Mb/s%{%f%}" # removed char not in my PowerLine font
        fi
}

# GCE Aliases.
# These override those provided by oh-my-zsh libs, plugins, and themes.
# Aliases can be placed here, though oh-my-zsh users are encouraged to
# define aliases within the ZSH_CUSTOM folder (GCE -> Don't give a c***).
#
# For a full list of active aliases, run `alias`.
#

echo -n "Calibrating aliases..."
# ----- Better Terminal

# --- edit: Opens any file in sublime editor
alias edit='sudo subl'

# --- Go back 1 directory level
alias ..='cd ../'

# --- Go back 2 directory levels
alias ...='cd ../../'

# --- Go back 3 directory levels
alias .3='cd ../../../'

# --- Go back 4 directory levels
alias .4='cd ../../../../'

# --- Go back 5 directory levels
alias .5='cd ../../../../../'

# --- Go back 6 directory levels
alias .6='cd ../../../../../../'

# --- Go back 1 directory level (for fast typists)
alias cd..='cd ../'

# --- apacheEdit: Edit apache conf files with PHPStorm
    # Known issue: PHPStorm updates through JetBrains Toolbox will break the pstorm launcher
    # To fix: in PHPStorm go to Tools->Create Command-line Launcher and accept to overwrite
    # Another fix: Use another editor, I don't care XD
alias apacheEdit='pstorm /usr/local/etc/httpd'

# --- Apachelogs: Shows apache error logs
alias apacheLogs="less +F /var/log/apache2/error_log"

# --- apacheRestart: Restart Apache
alias apacheRestart='sudo apachectl graceful'

# --- brew: update, outdated, upgrade, cleanup, doctor
    # This is my favorite alias.
alias brdr='brew update && brew outdated && brew upgrade && brew cleanup && brew doctor'

# --- cic: Make tab-completion case-insensitive
    # Another favorite.
alias cic='set completion-ignore-case On'

# --- cleanupDS: Recursively delete .DS_Store files
    # Note to self: I should add this to my repos alias. Done!
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

# --- c: Clear terminal display
    # Saving two keystrokes is a stroke of genius.
    # If it weren't for the composer plugin to hijack my one key clear...
alias clr='clear'

# --- Preferred 'cp' implementation
alias cp='cp -iv'

# --- cpu_hogs: find CPU hogs
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

# --- DT: Pipe content to file on MacOS Desktop
alias DT='tee ~/Desktop/terminalOut.txt'

# --- editHosts: Edit /etc/hosts file
    # This file requires OS X authentication to save. PHPStorm does not allow that and
    # I'm too lazy to look up why and how to circumvent it. So I just use Sublime Edit
    # Change the edit alias to use your favorite text editor
alias editHosts='edit /etc/hosts'

# --- ep: Edit this profile
alias ep='pstorm ~/.zshrc'

# --- sp: Source this profile
alias sp='clr && source ~/.zshrc'

# --- f: Opens current directory in MacOS Finder
alias f='open -a Finder ./'

# --- fix_stty: Restore terminal settings when screwed up
    # I have never used this
alias fix_stty='stty sane'

# --- flushDNS: Flush out the DNS Cache
alias flushDNS='dscacheutil -flushcache'

# --- herr: Tails HTTP error logs
alias herr='tail /var/log/httpd/error_log'

# --- ipInfo0: Get info on connections for en0
alias ipInfo0='ipconfig getpacket en0'

# --- ipInfo1: Get info on connections for en1
alias ipInfo1='ipconfig getpacket en1'

# --- Preferred 'less' implementation
alias less='less -FSRXc'

# --- Preferred 'ls' implementation
alias l='clear; ls -FGlAhp'

# --- lr: Display current directory tree
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

# --- lsock: Display open sockets
alias lsock='sudo /usr/sbin/lsof -i -P'

# --- lsockT: Display only open TCP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'

# --- lsockU: Display only open UDP sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'

# --- make10mb: Creates a file of 10mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'

# --- make1mb: Creates a file of 1mb size (all zeros)
alias make1mb='mkfile 1m ./1MB.dat'

# --- make5mb: Creates a file of 5mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'

# --- memHogsTop, memHogsPs:  Find memory hogs
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

# --- memHogsTop, memHogsPs:  Find memory hogs
alias memHogsTop='top -l 1 -o rsize | head -20'

# --- Preferred 'mkdir' implementation
alias mkdir='mkdir -pv'

# --- mountReadWrite: For use when booted into single-user
alias mountReadWrite='/sbin/mount -uw /'

# --- Preferred 'mv' implementation
alias mv='mv -iv'

# --- Start mysql as root, prompts for password
alias mysql="/usr/local/mysql/bin/mysql -uroot -p"

# --- netCons: Show all open TCP/IP sockets
alias netCons='lsof -i'

# --- numFiles: Count of non-hidden files in current dir
alias numFiles='echo $(ls -1 | wc -l)'

# --- ohmyzsh: Edit oh-my-zsh folder
alias ohmyzsh='pstorm ~/.oh-my-zsh'

# --- openPorts: All listening connections
alias openPorts='sudo lsof -i | grep LISTEN'

# --- path: Echo all executable Paths
alias path='echo -e ${PATH//:/\\n}'
alias p='path' # Because, why not?

# --- phpunit
alias phpunit='./vendor/phpunit/phpunit/phpunit'
alias pu='phpunit'

# --- qf: Quickly search for file
alias qf="find . -name "

# --- repos: Go to my GitHub repos folder
alias repos='cd ~/Dropbox\ \(Personal\)/Coding/Repos && cleanupDS'
alias ~r='repos'

# --- showBlocked: All ipfw rules inc/ blocked IPs
alias showBlocked='sudo ipfw list'

# --- topForever: Continual 'top' listing (every 10 seconds)
alias topForever='top -l 9999999 -s 10 -o cpu'

# --- ttop: top with minimal resources
alias ttop="top -R -F -s 10 -o rsize"

# --- which: Find executables
alias which='which -a'

# --- ~: Go Home
alias ~="cd ~"

# --- Always list directory contents upon 'cd'
cd () { builtin cd "$@"; ll; }

# --- ff: Find file under the current directory
ff () { /usr/bin/find . -name "$@" ; }

# --- ffe: Find file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }

# --- ffs: Find file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; }

# --- findPid: find out the pid of a specified process. May use regex E.g. findPid '/d$/'
findPid () { lsof -t -c "$@" ; }

# --- httpDebug: Download a web page and show info on what took time
httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

# --- httpHeaders: Grabs headers from web page
httpHeaders () { /usr/bin/curl -I -L $@ ; }

# --- mans: Display command man page and highlight search text
mans () {man $1 | grep -iC2 --color=always $2 | less }

# --- mcd: Makes new Dir and jumps inside
mcd () { mkdir -p "$1" && cd "$1"; }

# --- my_ps: display current user's process status
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,command ; }

# --- my_ip: display my public facing IP address
my_ip() { dig +short myip.opendns.com @resolver1.opendns.com }

# --- ql: Opens any file in MacOS Quicklook Preview
ql () { qlmanage -p "$*" >& /dev/null; }

# --- rmv: remove files/directories
rmv () { rm -dfr "$1" }

# --- spotlight: Search for a file using MacOS Spotlight's metadata
spot () { mdfind "kMDItemDisplayName == '$@'wc"; }

# --- trash: Moves a file to the MacOS trash
trash () { command mv "$@" ~/.Trash ; }

# --- zipf: To create a ZIP archive of a folder
zipf () { zip -r "$1".zip "$1" -x "*.DS_Store" -x "__MACOSX"; }

# --- cdf:  'Cd's to frontmost window of MacOS Finder
cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

# --- extract:  Extract most known archives with one command
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# --- ii:  display useful host related informaton
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ; my_ip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}

sleep 1
echo "done!"

echo -n "Configuring paths..."

export PATH="/usr/local/opt/apr/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/apr-util/bin:$PATH"
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/openldap/bin:$PATH"
export PATH="/usr/local/opt/openldap/sbin:$PATH"

sleep 1
echo "done!\n"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

sleep 1
echo "Ready!"

sleep 1
clr

artii 'Sup, noob!' | lolcat && fortune | cowsay -f vader | lolcat