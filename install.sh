# Development environment
mkdir ~/Code

# Die on failures
set -e

# Load global system
source ~/.setup/System/Global.sh

# Load profile paths
load System/Profile/Scripts/Paths.sh

# Install Homebrew
load System/Install/Homebrew.sh

# Install Apps
load System/Install/Apps.sh

# Install Bottles
load System/Install/Bottles.sh

# Install Composer Packages
load System/Install/Composer.sh

# Install Node Packages
load System/Install/Node.sh

# Install Pip Packages
load System/Install/Pips.sh

# Install Valet
load System/Install/Valet.sh

# Install Homestead
load System/Install/Homestead.sh

# Install Oh My ZSH
load System/Install/OhMyZSH.sh

# Configure Gitfiles
load System/Install/Gitfiles.sh

# Set permisions for Homebrew folder
sudo chown -R $(whoami) $(brew --prefix)/*

# Load profile in zshrc
echo 'source ~/.setup/System/Profile.sh' >> ~/.zshrc

print_success "Installation complete!"

# Do not die on failures
set +e

# Set variable to let scripts know that install have just been completed
INSTALL_COMPLETE=true
