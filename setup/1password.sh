#!/bin/bash
echo "First arg: $1"
echo "Second arg: $2"

# 1password.sh
# Link to SSH keys used in github, bitbucket, using 1Password CLI
# Link to SSH keys used in github, bitbucket, using 1Password CLI

echo "Setting up 1Password SSH Keys"
echo "🔏 Enable SSH agent and CLI integration in 1Password > Preferences > Developer"
read

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
op read "op://private/matrixssh/privatekey" > ~/.ssh/id_rsa
op read "op://private/matrixssh/publickey" > ~/.ssh/id_rsa.pub

# Add repos to known hosts
echo "Adding github.com and bitbucket.org to known_hosts"
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

# Create a symlink to the 1Password SSH agent socket
ln -s ~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

# Update SSH config
echo "Updating SSH config"
cat <<EOT >> ~/.ssh/config
Include /Users/ben/.colima/ssh_config

# All keys
Host *
  IdentityAgent "~/.1password/agent.sock"
  AddKeysToAgent yes
  UseKeychain yes

# Work GitHub
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa.pub
  IdentitiesOnly yes
# Work Bitbucket
Host bitbucket.org
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/id_rsa.pub
  IdentitiesOnly yes

# Fig ssh integration. Keep at the bottom of this file.
Match all
  Include ~/.fig/ssh
EOT

echo "✨ Done!"