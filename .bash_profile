#  ---------------------------------------------------------------------------
#
#  Description:  GCE BASH configurations and #aliases
#
#  Sections:
#  1.  Environment Configuration
#  2.  Make Terminal Better (remapping defaults and adding functionality)
#  3.  File and Folder Management
#  4.  Searching
#  5.  Process Management
#  6.  Networking
#  7.  System Operations & Information
#  8.  Web Development
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------
    # export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
    # export PS1="\n\[\e[1;32m\]\s \[\e[1;33m\]\d \[\e[1;33m\]\t@ \h (\u)\n\[\e[1;36m\]\w/\[\e[0;37m\]"
    # export PS1="\n\[\e[1;32m\]\u@\h\[\e[0;37m\]:\[\e[1;36m\]\w\[\e[1;36m\] \[\e[0;37m\]$ "
    export PS1="\n\[\e[1;33m\]\d \[\e[1;33m\]\t@\n\[\e[1;32m\]\u@\h\[\e[0;37m\]:\[\e[1;36m\]\w\[\e[1;36m\] \[\e[0;37m\]"
    export PS2="$ "

#   Set Paths
#   ------------------------------------------------------------
    # export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
    # export PATH="/usr/local/bin:$PATH"
    # export PATH="/usr/local/bin:/usr/local/git/bin:/usr/local:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin/clang:$PATH"
    # export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
    alias fixow='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'

#   Set architecture flags
#   ------------------------------------------------------------
    export ARCHFLAGS="-arch x86_64"

#   Load .bashrc if it exists
#   ------------------------------------------------------------
    test -f ~/.bashrc && source ~/.bashrc

#   Set Default Editor (change to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR=/usr/local/bin/sublime

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
    export BLOCKSIZE=1k

    export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

    export JAVA_HOME=$(/usr/libexec/java_home)

#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit="sudo /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias mysql=" sudo /usr/local/mysql/bin/mysql"

alias repos='cd ~/Dropbox\ \(Personal\)/Coding/Repos'
alias ep='edit ~/.bash_profile'
alias sp='source ~/.bash_profile'

alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)
alias qfind="find . -name "                 # qfind:        Quickly search for file

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview

#   mans:   Search manpage given in argument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.
#           Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an #alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/#aliases.bash | grep -v '^\s*$' | less -FSRXc ; }


#   -------------------------------
#   3. FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" -x "*.DS_Store" -x "__MACOSX"; }          # zipf:         To create a ZIP archive of a folder

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as #alias)
                on error
            set currFolder to (path to desktop folder as #alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   ---------------------------
#   4. SEARCHING
#   ---------------------------

ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6. NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address // GCE Not Working
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        echo
    }


#   ---------------------------------------
#   7. SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias fsh='defaults write com.apple.finder ShowAllFiles TRUE'
    alias fhh='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias ssDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8. WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='edit /usr/local/etc/httpd'            # apacheEdit:       Edit apach conf files
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='edit /etc/hosts'                       # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/apache2/access_log'           # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:       Shows apache error logs
httpHdrs () { /usr/bin/curl -I -L $@ ; }                # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

# No clue what this does
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
