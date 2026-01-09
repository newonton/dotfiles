#!/bin/sh
#
# Finder
#
# Configure macOS Finder defaults and view settings.
#

echo "  Installing Finder defaults for you."

# Close Finder, to prevent this from overriding settings.
osascript -e 'tell application "Finder" to quit'

# Preferences
defaults write com.apple.finder ShowHardDrivesOnDesktop         -bool true  # Show hard drives on Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true  # Show external hard drives on Desktop.
defaults write com.apple.finder ShowRemovableMediaOnDesktop     -bool true  # Show removable media on Desktop.
defaults write com.apple.finder ShowMountedServersOnDesktop     -bool true  # Show mounted servers on Desktop.
defaults write com.apple.finder FinderSpawnTab                  -bool true  # Open new Finder windows in a new tab by default.
defaults write com.apple.finder ShowRecentTags                  -bool false # Hide tags in sidebar.
defaults write NSGlobalDomain   AppleShowAllExtensions          -bool true  # Show all file extensions.
defaults write com.apple.finder FXEnableExtensionChangeWarning  -bool false # Disable file extension change warning.
# not found                                                                 # No warning before removing from iCloud Drive.
defaults write com.apple.finder WarnOnEmptyTrash                -bool false # No warning before emptying trash.
defaults write com.apple.finder FXRemoveOldTrashItems           -bool true  # Automatically remove items from Trash after 30 days.
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop"  -bool true  # Keep folders on top on Desktop.
defaults write com.apple.finder "_FXSortFoldersFirst"           -bool true  # Keep folders on top in Finder windows.

defaults write com.apple.finder ShowStatusBar      -bool true   # Show status bar.
defaults write com.apple.finder ShowPathbar        -bool true   # Show path bar.
defaults write com.apple.finder SidebarWidth2      -int  245    # Greater sidebar width.

defaults write com.apple.finder AppleShowAllFiles -bool true # Show hidden files.
chflags nohidden ~/Library                                   # Show the ~/Library folder.

# Do not create DS_Store files as much as possible
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores     -bool true

# Set default path for new windows.
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other        : `PfLo`
defaults write com.apple.finder NewWindowTarget PfHm

# Set search scope.
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
defaults write com.apple.finder FXDefaultSearchScope SCcf

# Set preferred view style.
# Icon View   : `icnv`
# List View   : `Nlsv`
# Column View : `clmv`
# Cover Flow  : `Flwv`
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Set toolbar.
plutil -remove "NSToolbar Configuration Browser"."TB Item Identifiers" ~/Library/Preferences/com.apple.finder.plist 2> /dev/null
plutil -insert "NSToolbar Configuration Browser"."TB Item Identifiers" -json \
  '[
    "com.apple.finder.BACK",
    "com.apple.finder.PATH",
    "com.apple.finder.NFLD",
    "com.apple.finder.AirD",
    "com.apple.finder.SHAR",
    "com.apple.finder.ACTN",
    "com.apple.finder.SRCH"
  ]' \
~/Library/Preferences/com.apple.finder.plist

# Set view settings.
plutil -remove ICloudViewSettings ~/Library/Preferences/com.apple.finder.plist 2> /dev/null
plutil -remove DesktopViewSettings ~/Library/Preferences/com.apple.finder.plist 2> /dev/null
plutil -remove StandardViewSettings.ExtendedListViewSettingsV2 ~/Library/Preferences/com.apple.finder.plist 2> /dev/null
plutil -remove StandardViewSettings.ListViewSettings ~/Library/Preferences/com.apple.finder.plist 2> /dev/null

plutil -insert StandardViewSettings.ExtendedListViewSettingsV2 -json \
  '{
    "calculateAllSizes": 1,
    "columns": [
        { "identifier": "name",             "ascending": 1, "visible": 1, "width": 300 },
        { "identifier": "ubiquity",         "ascending": 0, "visible": 1, "width":  35 },
        { "identifier": "size",             "ascending": 0, "visible": 1, "width":  75 },
        { "identifier": "kind",             "ascending": 1, "visible": 1, "width": 115 },
        { "identifier": "dateModified",     "ascending": 0, "visible": 0, "width": 181 },
        { "identifier": "dateCreated",      "ascending": 0, "visible": 0, "width": 181 },
        { "identifier": "dateLastOpened",   "ascending": 0, "visible": 0, "width": 181 },
        { "identifier": "dateAdded",        "ascending": 0, "visible": 0, "width": 181 },
        { "identifier": "label",            "ascending": 1, "visible": 0, "width": 100 },
        { "identifier": "version",          "ascending": 1, "visible": 0, "width":  75 },
        { "identifier": "comments",         "ascending": 1, "visible": 0, "width": 300 },
        { "identifier": "shareLastEditor",  "ascending": 0, "visible": 0, "width": 200 },
        { "identifier": "shareOwner",       "ascending": 0, "visible": 0, "width": 200 },
        { "identifier": "invitationStatus", "ascending": 0, "visible": 0, "width": 210 },
    ],
    "iconSize": 16,
    "showIconPreview": 1,
    "sortColumn": "name",
    "textSize": 13,
    "useRelativeDates": 1,
    "viewOptionsVersion": 1
  }' \
~/Library/Preferences/com.apple.finder.plist

plutil -insert DesktopViewSettings -json \
  '{
    "GroupBy": "Kind",
    "IconViewSettings": {
      "arrangeBy":  "dateAdded",
      "backgroundColorBlue":  1,
      "backgroundColorGreen": 1,
      "backgroundColorRed":   1,
      "backgroundType":       0,
      "gridOffsetX":          0,
      "gridOffsetY":          0,
      "gridSpacing":         54,
      "iconSize":            64,
      "labelOnBottom":        1,
      "showIconPreview":      1,
      "showItemInfo":         1,
      "textSize":            12,
      "showItemInfo":         1,
      "textSize":            13,
      "viewOptionsVersion":   1
    }
  }' \
~/Library/Preferences/com.apple.finder.plist

rm -rf "$HOME/Library/Mobile Documents/com~apple~CloudDocs/.DS_Store"
rm -rf "$HOME/.DS_Store"

echo "  Remove all .DS_Store files from the system?"
printf "  Do you want to continue? [y/N]: "
read answer </dev/tty

case "$answer" in
  y|Y|yes|YES)
    echo "  Removing .DS_Store files..."
    find / -name ".DS_Store" -type f -print -delete 2>/dev/null
    echo "  Done."
    ;;
  *)
    echo "  Cancelled."
    ;;
esac

exit 0
