# 1password.sh
# Get work and personal public SSH keys using 1Password CLI and insert them into ~/.ssh/

echo "Setting up 1Password SSH Keys"
echo "🔓 Enable SSH agent and CLI integration in 1Password > Preferences > Developer"
read

echo "⛔️ Overwrite SSH config? Press any key to continue, or Ctrl+C to cancel"
read
rm -rf ~/.ssh/
mkdir ~/.ssh/
touch ~/.ssh/config

op signout --all
op account forget --all

# read -r -p "Sign out and remove all accounts? [Y/n] " input 
# case $input in
#       [yY][eE][sS]|[yY])
#             op signout --all
#             op account forget --all
#             ;;
#       [nN][oO]|[nN])
#             ;;
#       *)
#             echo "Invalid input..."
#             exit 1
#             ;;
# esac



# TODO: Find a method of directly testing for 1Password CLI app integration
# Prompt user to choose between 1Password CLI app integration and manual signin
options=("Use 1Password CLI desktop app integration" "Sign in manually")
select opt in "${options[@]}"
do
    case $opt in
        "Use 1Password CLI desktop app integration")
            break
            ;;

        "Sign in manually")
            echo "Sign in manually..."
            # Add the accounts and signin manually
            eval $(op account add --address my.1password.com --email benhaldenby@gmail.com --secret-key A3-LHLCST-8MZPL3-QESHG-STNG4-Z82AW-9G79W --shorthand ben --signin)
            eval $(op account add --address matrixcreate.1password.com --email ben@matrixcreate.com  --secret-key A3-ZNK6LH-G93L36-FS982-3VH9G-6AMHF-ZSHXV --shorthand matrix --signin)

            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


# After you sign in, save your session token to an environment variable. 
# op account add --address my.1password.com --email wendy_appleseed@agilebits.com --shorthand personal
# Then, you'll be able to sign in using the account shorthand or ID. 
# For example: op signin --account personal.

echo "Authorise 1Password CLI to access your 1Password SSH keys..."

# Work
# Use the UUID to get the private key from the 1Password item and save it to ~/.ssh/id_rsa
op item get h65su5gwa4p6xloa2mwkmhxmsm --account matrixcreate.1password.com --fields label=privatekey > ~/.ssh/id_rsa
# Use the UUID to get the public key from the 1Password item and save it to ~/.ssh/id_rsa.pub
op item get h65su5gwa4p6xloa2mwkmhxmsm --account matrixcreate.1password.com --fields label=publickey  > ~/.ssh/id_rsa.pub

# Personal
# Use the UUID to get the private key from the 1Password item and save it to ~/.ssh/id_rsa_ben
op item get m4pyakfcvkuxizm6zhr5x53xf4 --account my.1password.com --fields label=privatekey > ~/.ssh/id_rsa_ben
# Use the UUID to get the public key from the 1Password item and save it to ~/.ssh/id_rsa_ben.pub
op item get m4pyakfcvkuxizm6zhr5x53xf4 --account my.1password.com --fields label=publickey  > ~/.ssh/id_rsa_ben.pub

# Add to known hosts
echo ""
echo "Adding github.com and bitbucket.org to known_hosts"
echo ""
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

# Update SSH config
echo "Updating SSH config"
cat <<EOT >> ~/.ssh/config
Include /Users/ben/.colima/ssh_config

# All keys
Host *
  IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  # IdentityAgent "~/.1password/agent.sock"
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

# Personal GitHub
Host github.com.ben
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_ben.pub
  IdentitiesOnly yes
# Personal Bitbucket
Host bitbucket.org.ben
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/id_rsa_ben.pub
  IdentitiesOnly yes

# Fig ssh integration. Keep at the bottom of this file.
Match all
  Include ~/.fig/ssh
EOT


echo "✨ Done!"