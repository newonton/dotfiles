# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Use AirDrop over every interface. srsly this should be a default.
# defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Run the screensaver if we're in the bottom-left hot corner.
# defaults write com.apple.dock wvous-bl-corner -int 5
# defaults write com.apple.dock wvous-bl-modifier -int 0

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

# Keyboard
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write NSGlobalDomain KeyRepeat        -int 1

# Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Switch input sources with CapsLock
defaults write NSGlobalDomain TISRomanSwitchState -bool true

# Set input sources ABC and Russian.
defaults write com.apple.HIToolbox AppleFnUsageType -int 2
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

# Text correction
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
defaults write com.apple.iCal "first day of week"            -int 2 # Monday
defaults write com.apple.iCal "scroll by weeks in week view" -int 2 # Week, Stop on Today
defaults write com.apple.iCal "CalDefaultCalendar"           -string "4361A7DB-3B54-4553-A20A-4A53D01402E9" # onton calendar

defaults write com.apple.iCal "SharedCalendarNotificationsDisabled" -bool false
defaults write com.apple.iCal "InvitationNotificationsDisabled"     -bool false

defaults write com.apple.iCal "TimeZone support enabled"     -bool true
defaults write com.apple.iCal "Show heat map in Year View"   -bool true
defaults write com.apple.iCal "Show Week Numbers"            -bool true
defaults write com.apple.iCal "InviteeDeclineAlerts"         -bool true
defaults write com.apple.iCal "OpenEventsInWindowType"       -bool false
defaults write com.apple.iCal "WarnBeforeSendingInvitations" -bool true
