# git.sh

# Set up git defaults
git config --global user.name "Ben Haldenby"
git config --global user.email "benhaldenby@gmail.com"

# Generate two SSH keys
ssh-keygen -f ~/.ssh/id_rsa -N ""
ssh-keygen -f ~/.ssh/id_rsa_ben -N ""

# Echo the copy commands one by one
echo "Copy the SSH keys to the clipboard"
echo "pbcopy < ~/.ssh/id_rsa"
echo "pbcopy < ~/.ssh/id_rsa_ben"
echo "and paste the output into GitHub"

# Add keys to ssh-agent
ssh-add -K ~/.ssh/id_rsa
ssh-add -K ~/.ssh/id_rsa_ben

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
