# Set up local Projects directories

echo "Creating local Projects directories"
mkdir -p $HOME/Local $HOME/Local/Projects/Ben $HOME/Local/Projects/Matrix

echo "Symlinking ~/Downloads to iCloud"
# Symlink ~/Downloads to iCloud
sudo mv ~/Downloads ~/Downloads.backup
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads ~/Downloads
rm -rf ~/Downloads.backup