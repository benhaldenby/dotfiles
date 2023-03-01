# 1password.sh
# Get work and personal public SSH keys using 1Password CLI and insert them into ~/.ssh/

echo "🔑 Setting up 1Password SSH keys"
echo "Enable the SSH agent in 1Password > Preferences > Developer"

echo "⚠️ Overwrite SSH config?"
echo "Press any key to continue, or Ctrl+C to cancel"
read

echo "🔥 Removing existing SSH config"
rm -rf ~/.ssh/
mkdir ~/.ssh/
touch ~/.ssh/config

echo "Getting SSH keys from 1Password..."

# If 1password cli app integration is not availabe, then add the account manually

#op account add --address my.1password.com --email benhaldenby@gmail.com --secret-key A3-LHLCST-8MZPL3-QESHG-STNG4-Z82AW-9G79W
#eval $(op signin)
#op account add --address matrixcreate.1password.com --email ben@matrixcreate.com  --secret-key A3-ZNK6LH-G93L36-FS982-3VH9G-6AMHF-ZSHXV
#eval $(op signin)

# Work
op item get h65su5gwa4p6xloa2mwkmhxmsm --account PZOFM37IGVFUJJ2GNL5P7W2YJA --fields label=privatekey > ~/.ssh/id_rsa
op item get h65su5gwa4p6xloa2mwkmhxmsm --account PZOFM37IGVFUJJ2GNL5P7W2YJA --fields label=publickey  > ~/.ssh/id_rsa.pub

# Personal
op item get m4pyakfcvkuxizm6zhr5x53xf4 --account YRP74L5VUNFUHOEPTMT4V7FHOM --fields label=privatekey > ~/.ssh/id_rsa_ben
op item get m4pyakfcvkuxizm6zhr5x53xf4 --account YRP74L5VUNFUHOEPTMT4V7FHOM --fields label=publickey  > ~/.ssh/id_rsa_ben.pub

# Add to known hosts
echo "Adding github.com and bitbucket.org to known_hosts"
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

# Update SSH config
echo "Updating SSH config..."
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
