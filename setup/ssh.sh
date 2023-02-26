# git.sh

# Set up git defaults
git config --global user.name "Ben Haldenby"
git config --global user.email "benhaldenby@gmail.com"

# Generate two SSH keys
ssh-keygen -f ~/.ssh/id_rsa -N ""
ssh-keygen -f ~/.ssh/id_rsa_ben -N ""

# Add default key to ssh-agent
ssh-add --apple-use-keychain ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa
# Prompt user to add the key to GitHub
echo "📋 id_rsa key copied to clipboard!"
echo "Go paste into GitHub..."
read

# Add 'ben' key to ssh-agent
ssh-add --apple-use-keychain ~/.ssh/id_rsa_ben
pbcopy < ~/.ssh/id_rsa_ben
# Prompt user to add the key to GitHub
echo "📋 id_rsa_ben copied to clipboard!"
echo "Go paste into GitHub..."
read

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
