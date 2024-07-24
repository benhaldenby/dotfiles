# git.sh

# Create fresh SSH config
echo "⚠️ Are you sure you want to overwrite your SSH config? Press any key to continue, or Ctrl+C to cancel"
read
echo "🔥 Removing existing SSH config"
rm -rf ~/.ssh/
mkdir ~/.ssh/
touch ~/.ssh/config

# Set up git defaults
echo "👩‍💻 Setting up git user defaults"
git config --global user.name "Ben Haldenby"
git config --global user.email "benhaldenby@gmail.com"

echo "🔑 Generating SSH keys"
# Generate default SSH key
ssh-keygen -f ~/.ssh/id_rsa -N ""
# Add key to ssh-agent
ssh-add --apple-use-keychain ~/.ssh/id_rsa
# Prompt user to add the key to GitHub
pbcopy < ~/.ssh/id_rsa.pub
echo "📋 ~/.ssh/id_rsa.pub copied to clipboard!"
echo "🔗 Go to https://github.com/settings/keys and paste the key into the 'New SSH key' form"
echo "Press any key to continue"
read

# Generate 'ben' SSH key
ssh-keygen -f ~/.ssh/id_rsa_ben -N ""
# Add key to ssh-agent
ssh-add --apple-use-keychain ~/.ssh/id_rsa_ben
# Prompt user to add the key to GitHub
pbcopy < ~/.ssh/id_rsa_ben.pub
echo "📋 ~/.ssh/id_rsa_ben.pub copied to clipboard!"
echo "🔗 Go to https://github.com/settings/keys and paste the key into the 'New SSH key' form"
echo "Press any key to continue"
read

# Add to known hosts
echo "Adding github.com and bitbucket.org to known_hosts"
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

# Insert SSH config for multiple keys
echo "Writing SSH config"
cat << EOF >> ~/.ssh/config

# All keys
Host *
 AddKeysToAgent yes
 UseKeychain yes

# Default SSH keys
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

Host github.com.sr
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_shroomrise
  IdentitiesOnly yes

Host github.com.af
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_affulfilment
  IdentitiesOnly yes
EOF

echo "Done!"