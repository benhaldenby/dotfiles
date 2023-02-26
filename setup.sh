echo "Setting up your Mac..."

# const
COMPUTERNAME="MacBook Pro"

# Setup path
# sh setup/path.zsh

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  # eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc


# Aliases
sh setup/aliases.sh

# Local directory setup
sh setup/local.sh

# git setup
sh setup/git.sh

# Setup Projects directories
sh setup/projects.sh

# Clone repositories
sh setup/repos.sh

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file Brewfile

# Tower
sh install/tower.sh

# Open Apps folder
open ~/Library/Mobile\ Documents/com~apple~CloudDocs/NewOS/Apps/

# Set default MySQL root password and auth type
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"


# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Alias
alias ls="ls -al"
# export PATH alias ls="ls -al"


# Install docker, colima, ddev (error prone 260223)
# brew install colima
# brew install docker
# colima start --cpu 4 --memory 6 --disk 100 --vm-type=qemu --mount-type=sshfs --dns=1.1.1.1
# brew install drud/ddev/ddev
# mkcert -install


# Symlink the Mackup config file to the home directory
ln -s .mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source .macos
