echo "Setting up your Mac..."

# User values
COMPUTERNAME="MacBook Pro"

# Setup path
# sh setup/path.sh

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc


# Aliases
sh setup/aliases.sh

# Local directory setup
sh setup/folders.sh

# SSH setup
# sh setup/ssh.sh

# Clone repositories
sh setup/repos.sh

# Update Homebrew recipes
# sh setup/brew.sh

# Tower
# sh setup/tower.sh

# Set default MySQL root password and auth type
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Install nvm
sh setup/nvm.sh

# Install docker, colima, ddev (error prone 260223)
sh setup/docker.sh

# Symlink the Mackup config file to the home directory
ln -s .mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source .macos
