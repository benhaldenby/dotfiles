#!/bin/bash

# Use 1Password CLI to get and link SSH keys used in github, bitbucket
echo "Setting up 1Password SSH Keys"
echo "Logged in:"
op whoami
echo ""
echo "🔏 Enable SSH agent and CLI integration in 1Password > Preferences > Developer"
#read


# TODO: When is it necessary to signout of all accounts?
#op signout --all
#op account forget --all

# Prompt user to choose between 1Password CLI app integration and manual signin
# TODO: Find a method of directly testing for availablity of 1Password CLI app integration
options=("Use 1Password CLI desktop app integration" "Sign in manually...")
select opt in "${options[@]}"
do
    case $opt in
        "Use 1Password CLI desktop app integration")
            break
            ;;

        "Sign in manually...")
            # Sign in to 1Password CLI
            eval $(op account add --signin)
            break
            ;;
        *) echo "invalid option $REPLY";
    esac
done

# After you sign in, save your session token to an environment variable. 
# op account add --address my.1password.com --email wendy_appleseed@agilebits.com --shorthand personal
# Then, you'll be able to sign in using the account shorthand or ID. 
# For example: op signin --account personal.

echo "🔓 Authorising 1Password CLI to access your 1Password SSH keys..."

# Get private and public keys, referencing the 1Password item by UUID, and save to ~/.ssh/
# Work

# Create the .ssh directory if it doesn't exist
mkdir -p ~/.ssh

# Ask for a FILENAME for the new ssh keys
echo "Enter the vault and item name for the SSH keys you want to use"
read -p "vault: " VAULTNAME
read -p "item: " ITEMNAME
echo "Enter an alias to use for the filename and config file (leave blank for standard: id_rsa)"
read ALIAS

# Set a standard id_rsa filename, or use the ALIAS if it was set
if [ -z "$ALIAS" ]; then
  FILENAME="id_rsa"
  HOSTEXTENSION=""
else
  FILENAME="id_rsa_"$ALIAS
  HOSTEXTENSION="."$ALIAS
fi
echo "SSH key set ~/.ssh/"$FILENAME
echo "~/.ssh/config: Host github.com$HOSTEXTENSION"

# Get the private and public keys from 1Password, and save them to ~/.ssh
op read "op://$VAULTNAME/$ITEMNAME/privatekey" > ~/.ssh/$FILENAME
op read "op://$VAULTNAME/$ITEMNAME/publickey" > ~/.ssh/$FILENAME.pub
# set read/write permissions for current user only
chmod 600 ~/.ssh/$FILENAME
chmod 600 ~/.ssh/$FILENAME.pub

# Prompt the user for confirmation
read -p "Add github.com and bitbucket.org to ~/.ssh/known_hosts? (y/N) " response

# Check the user's response
if [[ $response =~ ^[Yy]$ ]]; then
    # Add github.com and bitbucket.org to ~/.ssh/known_hosts
    ssh-keyscan github.com bitbucket.org >> ~/.ssh/known_hosts
fi

# Create a symlink to the 1Password SSH agent socket
#mkdir -p ~/.1password
#ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

# Update SSH config
echo "Updating SSH config"

cat << _EOF >> ~/.ssh/config

Host github.com$HOSTEXTENSION
  HostName github.com
  User git
  IdentityFile ~/.ssh/$FILENAME.pub
  IdentitiesOnly yes

Host bitbucket.org$HOSTEXTENSION
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/$FILENAME.pub
  IdentitiesOnly yes

_EOF

echo "✨ Done!"