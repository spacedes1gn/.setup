if [[ $INSTALL_ZSH ]]; then
	# Remove terminal login message
	touch ~/.hushlogin
	
    # Install Oh My ZSH
    print_header "Installing Oh My ZSH..."
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
    print_header "Oh My ZSH installed."
fi