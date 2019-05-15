# Empty Trash
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Airport/Wifi Scan - get details: airport -s
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport'

# Show hidden files
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# Hide hidden files
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Show desktop files
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Hide desktop files
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'

# Enable autocorrect
alias enableAutocorrect='defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true'

# Disable autocorrect
alias disableAutocorrect='defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false'

# Clear User Setup Config
alias clear-setup-config='rm -rf ~/.SetupUserConfig; cp -r ~/.setup/Config ~/.SetupUserConfig'

# Clear setup cache
alias clear-setup-cache='rm -rf ~/.setup/.cache'

# Cleanup Mac
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete'"

# Prevent Mac From Sleep - choose seconds: nosleep -u -t 3600
alias nosleep='caffeinate'

# List users
alias list-users='dscl . list /Users | grep -v ^_.*'

# Lock Mac
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Schedule Mac Shutdown - choose minutes: 60
alias off='sudo shutdown -h +60'

# Kill Clean My Mac
alias killCMM='sudo pkill CleanMyMac X HealthMonitor && sudo pkill com.macpaw.CleanMyMac4.Agent'

# Config files
alias setup='subl ~/.setup'
alias apps='subl ~/.setup/Config/Apps.sh'
alias bottles='subl ~/.setup/Config/Bottles.sh'
alias paths='subl ~/.setup/System/Profile/Paths.sh'
alias aliases='subl ~/.setup/System/Profile/Aliases.sh'
alias functions='subl ~/.setup/System/Profile/Functions.sh'

# Reload profile
alias reload='source ~/.zshrc'

# Terminal Navigation
alias c='clear'
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias ls='ls -G'
alias la='ls -a'
alias lsla='ls -la'
alias ll='ls -lah'
alias lsd="ls -l | grep '^d'"
alias home='cd ~/'
alias dl='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias code='cd ~/Code'
alias apis='cd ~/Code/Laravel'
alias nuxt='cd ~/Code/Nuxt'
alias react='cd ~/Code/React'

# Network
alias ip='curl icanhazip.com'
alias ipinfo='curl ipinfo.io'
alias ipconfig='/sbin/ifconfig'
alias hosts='sudo vim /etc/hosts'
alias online="echo 'Ping Duckduckgo.com' && ping duckduckgo.com'"
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# Homebrew
alias add='brew install'
alias remove='brew uninstall --force'
alias install='brew cask install'
alias uninstall='brew cask uninstall --force'
alias services='brew services list'
alias service='brew services'
alias run='brew services run'
alias start='brew services start'
alias stop='brew services stop'
alias search='brew search'
alias formulas='brew list'
alias casks='brew cask list'
alias link='brew link'
alias unlink='brew unlink'
alias switch='brew switch'

# Yarn
alias y='yarn'
alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add --dev'
alias yc='yarn create'
alias ycn='yarn create nuxt-app'
alias ycr='yarn create react-app'
alias yr='yarn remove'
alias yd='yarn dev'
alias yw='yarn watch'
alias ys='yarn serve'
alias yb='yarn build'
alias yg='yarn generate'

# Artisan
alias art='php artisan'
alias tinker='php artisan tinker'
alias m='php artisan migrate'
alias mf='php artisan migrate:fresh'
alias mfs='php artisan migrate:fresh --seed'
alias mr='php artisan migrate:reset'
alias mr='php artisan migrate:rollback'

# Development
alias s="subl"
alias s.='subl .'
alias gw='gulp watch'
alias gitmsg='curl -s http://whatthecommit.com/index.txt'
alias laravel-cs-fixer='php-cs-fixer fix . --fixers=\'-psr0\'
alias site='laravel new'
alias sql='brew services run mysql'
alias hsql='brew services stop mysql'
alias mdb='brew services run mongodb'
alias hmdb='brew services stop mongodb'
alias share='ngrok http'
alias add-key='ssh-add ~/.ssh/max'

# Docker
alias dk='docker'
alias dkb='docker build'
alias dkex='docker exec'
alias dkexit='docker exec -it'
alias dknet='docker network'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dkr='docker run'
alias dkrit='docker run -it'
alias dkv='docker version'
alias dkvol='docker volume'

# Git
alias gs='git status'
alias gl='git pull'
alias gp='git push'
alias gpu='git push -u origin master'
alias gd='git diff --no-color | $EDITOR'
alias ga='git add'
alias gcl='git config --list'
alias gc='git commit -m'
alias gca='git commit -v -a'
alias gb='git branch'
alias gbc='git branch --color'
alias gba='git branch -a'
alias gco='git checkout'
alias gpatch='git diff master -p'
alias gitrm="git status | grep deleted | awk '{print $3}' | xargs git rm"
alias grel="git push && git checkout master && git push && git push heroku master && git checkout develop"

# Random
alias lookbusy="cat /dev/urandom | hexdump -C | grep --color 'ca fe'"
alias morning='open spotify:track:05NYcsjJwOYq4jIiKPVj9p'
