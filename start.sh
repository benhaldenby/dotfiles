# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 1Password
brew install --cask 1password

# Set up git defaults
git config --global user.name "Ben Haldenby"
git config --global user.email "benhaldenby@gmail.com"

# Generate two SSH keys
ssh-keygen -f ~/.ssh/id_rsa -N ""
ssh-keygen -f ~/.ssh/id_rsa_ben -N ""

# Echo the copy commands one by one
echo "pbcopy < ~/.ssh/id_rsa"
echo "pbcopy < ~/.ssh/id_rsa_ben"

# Add SSH keys to github.com, bitbucket.org

# Add to known hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts


# Insert SSH config for multiple keys
cat << EOF >> ~/.ssh/config
# All keys
Host *
 AddKeysToAgent yes
 UseKeychain yes

# Matrix SSH keys
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
  IdentitiesOnly yes

Host bitbucket.com
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/id_rsa
  IdentitiesOnly yes


# Personal SSH keys
Host github.com.ben
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_ben
  IdentitiesOnly yes

Host bitbucket.org.ben
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/id_rsa_ben
  IdentitiesOnly yes
EOF


# Clone dotfiles repo
git clone git@github.com:benhaldenby/dotfiles.git

# Alias
alias ls="ls -al"
export PATH alias ls="ls -al"


# Run fresh install script
# sh fresh.sh


# Install Node
brew install node

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install docker, colima, ddev
# brew install colima
# brew install docker

# colima start --cpu 4 --memory 6 --disk 100 --vm-type=qemu --mount-type=sshfs --dns=1.1.1.1

# brew install drud/ddev/ddev

# mkcert -install

# .macos dotfiles
# Dock needs work


# Symlink Downloads to iCloud
sudo mv Downloads Downloads.backup
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads Downloads
