#!/bin/bash

# Use 1Password CLI to get and link SSH keys used in github, bitbucket
echo ""
echo "🔐 Setting up 1Password SSH Keys"
echo ""
echo "Enable SSH Agent and 1Password CLI in 1Password > Preferences > Developer"
echo "If you don't have 1Password CLI enabled, you'll need to sign in manually"
read

# Create the .ssh directory if it doesn't exist
mkdir -p ~/.ssh && chmod 700 ~/.ssh
touch ~/.ssh/config
chmod 600 ~/.ssh/config

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
      eval $(op signin)  # this will trigger the next account wizard if there are no accounts
      sleep 1
      op whoami
      echo ""
      break
      ;;

    "Sign in manually...")
      # Sign in to 1Password CLI

      ACCOUNTS=$(op account list)  # run the command and capture its output
      if [ -z "$ACCOUNTS" ]; then  # check if the output is empty
        eval $(op signin)
      else
        echo "Available accounts:"
        op account list
        read -p "Add another account? [y/N]" ADDACCOUNT
        if [[ $ADDACCOUNT =~ ^[Yy]$ ]]; then
          # Add another account
          eval $(op account add --signin)
        else
          eval $(op signin)
        fi  
      fi

      break
      ;;
    *) echo "invalid option $REPLY";
  esac

  echo "🔓 Authorising 1Password CLI to access your 1Password SSH keys..."
  sleep 1
  op whoami
done

# Ask for a FILENAME for the new ssh keys
echo "Enter the vault and item name for the SSH keys you want to use"

# Select a vault name
#echo "Choose a vault:"
PS3="Choose a vault: "
options=("private" "personal")
select opt in "${options[@]}"
do
    case $opt in
        "private")
            VAULTNAME="private"
            break
            ;;

        "personal")
            VAULTNAME="personal"
            break
            ;;
        *) echo "invalid option $REPLY";
    esac
done

# Select an item name
read -p "Enter an item: [sshkey]" ITEMNAME
if ITEMNAME=""; then
  ITEMNAME="sshkey"
fi

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
#echo "⏳ Writing SSH keys to ~/.ssh/"$FILENAME
#echo "⏳ Writing 'Host github.com$HOSTEXTENSION' to ~/.ssh/config"

# Get the private and public keys from 1Password, and save them to ~/.ssh
op read "op://$VAULTNAME/$ITEMNAME/privatekey" > ~/.ssh/$FILENAME
op read "op://$VAULTNAME/$ITEMNAME/publickey" > ~/.ssh/$FILENAME.pub
# set read/write permissions for current user only
chmod 600 ~/.ssh/$FILENAME
chmod 600 ~/.ssh/$FILENAME.pub

#echo op read "op://personal/sshkey/privatekey"
#echo op read "op://$VAULTNAME/sshkey/privatekey"
#cat ~/.ssh/$FILENAME.pub

# Prompt the user for confirmation
read -p "Add hosts to ~/.ssh/known_hosts? [y/N]" ADDHOSTS

# Check the user's response
if [[ $ADDHOSTS =~ ^[Yy]$ ]]; then
  # Add github.com and bitbucket.org to ~/.ssh/known_hosts
  ssh-keyscan github.com bitbucket.org >> ~/.ssh/known_hosts
  echo "⏳ Updating SSH config"
fi

# Symlink ~/.1password/agent.sock to the 1Password SSH agent socket that is tucked away in ~/Library
mkdir -p ~/.1password
ln -sf ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock

# Update SSH config
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
--------------------

_EOF

echo "✨ Done!"
