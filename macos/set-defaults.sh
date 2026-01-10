# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Hide Safari's bookmark bar.
# defaults write com.apple.Safari.plist ShowFavoritesBar -bool false

# Set up Safari for development.
# defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
# defaults write com.apple.Safari.plist IncludeDevelopMenu -bool true
# defaults write com.apple.Safari.plist WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari.plist "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


# Settings
# Close open System Preferences panes, to prevent them from overriding settings.
osascript -e 'tell application "System Preferences" to quit'

defaults write NSGlobalDomain AppleInterfaceStyle Dark  # Use dark menu bar and dock.

# Dock
defaults write com.apple.dock tilesize      -int 55    # Set dock icon size.
defaults write com.apple.dock magnification -bool true # Enable dock magnification.
defaults write com.apple.dock largesize     -int 85    # Set dock magnificated icon size.

defaults write com.apple.dock minimize-to-application     -bool true  # Disable open windows Dock section.
defaults write com.apple.dock show-recents                -bool false # Disable resent apps.
defaults write com.apple.dock showAppExposeGestureEnabled -bool true  # Enable app expose gesture for trackpad.

defaults write NSGlobalDomain AppleWindowTabbingMode             always # Always open new documents in tabs.
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -bool true   # Ask to keep changes when closing documents.

# Hot Corners
defaults write com.apple.dock wvous-br-corner   -int 1 # Bottom right corner does nothing.
defaults write com.apple.dock wvous-br-modifier -int 0

defaults write com.apple.dock wvous-bl-corner   -int 5 # Bottom left corner run the screensaver.
defaults write com.apple.dock wvous-bl-modifier -int 0

killall Dock

# Keyboard
# Set a really fast key repeat.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat        -int 2

# Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Switch input sources with CapsLock.
defaults write NSGlobalDomain TISRomanSwitchState -bool true

# The globe shows emoji and symbols.
defaults write com.apple.HIToolbox AppleFnUsageType -int 2

# Set input sources ABC and Russian.
plutil -replace AppleEnabledInputSources -json \
  '[
    {
      "InputSourceKind":     "Keyboard Layout",
      "KeyboardLayout ID":    252,
      "KeyboardLayout Name": "ABC",
    },
    {
      "InputSourceKind":     "Keyboard Layout",
      "KeyboardLayout ID":    19456,
      "KeyboardLayout Name": "Russian",
    },
    {
      "InputSourceKind": "Non Keyboard Input Method",
      "Bundle ID":       "com.apple.CharacterPaletteIM",
    }
  ]' \
~/Library/Preferences/com.apple.HIToolbox.plist

# Text correction.
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled  -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled      -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled    -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled  -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled    -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled   -bool false

# Smart quotes.
defaults write NSGlobalDomain "KB_DoubleQuoteOption" -string "\\U00ababc\\U00bb"
defaults write NSGlobalDomain "KB_SingleQuoteOption" -string "'abc'"
defaults write NSGlobalDomain NSUserQuotesArray      -array "\\U00ab" "\\U00bb" "'" "'"

# Turn off text replacements.
defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array


# Calendar
# Close open Calendar windows, to prevent them from overriding settings.
osascript -e 'tell application "Calendar" to quit'

defaults write com.apple.iCal "first day of week"            -int     2 # Monday
defaults write com.apple.iCal "scroll by weeks in week view" -int     2 # Week, Stop on Today
defaults write com.apple.iCal CalDefaultCalendar             -string "UseLastSelectedAsDefaultCalendar"

defaults write com.apple.iCal SharedCalendarNotificationsDisabled -bool false
defaults write com.apple.iCal InvitationNotificationsDisabled     -bool false

defaults write com.apple.iCal "TimeZone support enabled"   -bool true
defaults write com.apple.iCal "Show heat map in Year View" -bool true # Show events in Year View
defaults write com.apple.iCal "Show Week Numbers"          -bool true
defaults write com.apple.iCal InviteeDeclineAlerts         -bool true
defaults write com.apple.iCal OpenEventsInWindowType       -bool false
defaults write com.apple.iCal WarnBeforeSendingInvitations -bool true
