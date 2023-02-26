# projects.sh

# Set up local Projects directories
echo "Creating local Projects directories"
# Create a Local directory
mkdir $HOME/Local

# Add directories for work and personal projects
mkdir $HOME/Local/Projects
mkdir $HOME/Local/Projects/Ben
mkdir $HOME/Local/Projects/Matrix

# Symlink ~/Downloads to iCloud
sudo mv ~/Downloads ~/Downloads.backup
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads ~/Downloads
rm -rf ~/Downloads.backup