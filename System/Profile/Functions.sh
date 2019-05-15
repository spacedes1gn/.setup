# Create and link valet site
function __valet_site () {
  if [[ -z $1 ]]; then
    print_error 'Missing argument [name].'
  else
    GO=$(pwd)
    cd $VALET_PATH
    laravel new $1
    cd $1
    valet secure
    cd $GO
  fi
}
alias valet-site='__valet_site'

# PHP server
function serve () {
    if [ $# -eq 1 ]; then
        php -S 0.0.0.0:$1
    else
        php -S 0.0.0.0:8000
    fi
}

# Search node docs
function __node_docs {
    local section=${1:-all}
    open 'https://nodejs.org/docs/$(node --version)/api/$section.html'
}
alias node-docs='__node_docs'

# Search laravel docs
function __laravel_docs {
    local section=${1:-''}
    open 'https://laravel.com/docs/$section'
}
alias laravel-docs='__laravel_docs'

# IP/ASN lookup by using cymru's whois server
#>whois 8.8.8.8
#AS      | IP               | AS Name
#15169   | 8.8.8.8          | GOOGLE - Google Inc., US
#>cwhois as15169
#AS Name
#GOOGLE - Google Inc., US
function cwhois() {
    whois -h whois.cymru.com '$@';
}

# Make shorthand for The Fuck
# https://github.com/nvbn/thefuck
eval $(thefuck --alias)

# Homebrew update
__is_pinned() {
  local pinned=";pixate-studio;sketchup;skype;" # TODO: Get real pinned!
  [[ *";${1};"* != "${pinned}" ]] && return 0 || return 1
}

__brew_update() {
  (set -x; brew update;)
  (set -x; brew cask update;)

  (set -x; brew cleanup;)
  (set -x; brew cask cleanup;)

  red=`tput setaf 1`
  green=`tput setaf 2`
  reset=`tput sgr0`

  casks=( $(brew cask list) )

  for cask in ${casks[@]}
  do
      installed="$(brew cask info $cask | grep 'Not installed')"

      if [[ $installed = *[!\ ]* ]]; then
        if ! __is_pinned "${name}"; then
          echo "${red}${cask}${reset} requires ${red}update${reset}."
          (set -x; brew cask install $cask --force;)
        else
          echo "${red}${cask}${reset} is pinned."
        fi
      else
          echo "${red}${cask}${reset} is ${green}up-to-date${reset}."
      fi
  done
}

alias brew-update="__brew_update"
