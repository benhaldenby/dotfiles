# Set up local Projects directories

echo "Creating local repo folders"
mkdir -p $HOME/Local/Matrix $HOME/Local/Ben

# Symlink ~/Downloads to iCloud
echo "Symlinking ~/Downloads to iCloud"
sudo mv ~/Downloads ~/Downloads.backup
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads ~/Downloads
rm -rf ~/Downloads.backup

# Open Apps folder
echo "Opening NewOS/Apps folder..."
open ~/Library/Mobile\ Documents/com~apple~CloudDocs/NewOS/Apps/
