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
<<<<<<< HEAD

# Alias
alias ls="ls -al"
export PATH alias ls="ls -al"

=======
>>>>>>> e630181fb4dfe93d5835b7e9e2a7a7cbe9bed6a5

# Run fresh install script
# sh fresh.sh

<<<<<<< HEAD
=======
# Install docker, colima, ddev
brew install colima
brew install docker

colima start --cpu 4 --memory 6 --disk 100 --vm-type=qemu --mount-type=sshfs --dns=1.1.1.1

brew install drud/ddev/ddev
mkcert -install
>>>>>>> e630181fb4dfe93d5835b7e9e2a7a7cbe9bed6a5

# Install Node
brew install node

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

<<<<<<< HEAD
# Install docker, colima, ddev
# brew install colima
# brew install docker

# colima start --cpu 4 --memory 6 --disk 100 --vm-type=qemu --mount-type=sshfs --dns=1.1.1.1

# brew install drud/ddev/ddev

# mkcert -install

# Install CompanyPortal app
# Install Teams
=======
>>>>>>> e630181fb4dfe93d5835b7e9e2a7a7cbe9bed6a5

# Newsquest
brew install --cask intune-company-portal
brew install --cask microsoft-teams
brew install --cask microsoft-outlook
brew install --cask microsoft-word
brew install --cask microsoft-excel

# LittleSnitch
brew install --cask little-snitch
# Ben Haldenby
# 35UG7BTXY2-715NS-Z6W2EYARJ8

<<<<<<< HEAD
# .macos dotfiles

# Dock

# Symlink Downloads to iCloud
sudo mv Downloads Downloads.backup
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads Downloads

=======
# Launchbar
brew install --cask launchbar
# 16UG7BTXY1-717L1-M1EMDMTDZJ

# Tower
/Volumes/iCloud/NewOS/Tower_Pro_6.0.dmg

# AppCleaner
brew install --cask appcleaner


# Audio Hijack
brew install --cask audiohijack
# STCK-Y4GC-QEFA-EV9C-9NKY-WUP4-GPXR-YPE4-H4MR

# Farrago
brew install --cask farrago
# FEBE-QKAW-EMVU-4668-QXKD-G2VY-MBCY-RMJC-24XF

# SoundSource
brew install --cask soundsource
# ZLAT-RKN3-ZA2M-BFWD-8FZJ-DE23-W9XJ-2U8N-DHDA
>>>>>>> e630181fb4dfe93d5835b7e9e2a7a7cbe9bed6a5
