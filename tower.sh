# Mounting Tower 6 DMG
echo "Installing Tower Pro"
echo "--------------------"

echo "🚧 Mounting DMG and copying Tower.app..."
MOUNTED_PATH="/Volumes/Tower Pro/"
# Mount DMG
hdiutil attach ~/Library/Mobile\ Documents/com~apple~CloudDocs/NewOS/Apps/Tower_Pro.dmg # && open "$MOUNTED_PATH/Tower.app"
sleep 1
cp -R "$MOUNTED_PATH/Tower.app" "/Applications/Tower.app"


echo "Open License Generator..."
open "$MOUNTED_PATH/Tower 6 [Lic].app"

echo "🤫 Block Tower with Little Snitch"
echo "🔓 Allow License Generator to Open in Privacy & Security Settings..."
open "/Applications/Little Snitch.app"
open /System/Library/PreferencePanes/Security.prefPane
# wait
echo "⏳ Press any key to continue..."
read -n 1

hdiutil detach "/Volumes/Tower Pro"