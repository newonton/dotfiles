#!/bin/sh
#
# Apple Terminal
#
# This installs all *.terminal profiles from the terminal folder
# and sets the first one as default. Skips already installed profiles.
# The profile name must be the same as the file name.
#

# Check for Terminal
if [ ! -d "/System/Applications/Utilities/Terminal.app" ]
then
  echo "  Terminal.app not found, skipping."
  exit 0
fi

echo "  Installing Terminal profiles for you."

set -- $ZSH/terminal/*.terminal
if [ ! -f "$1" ]
then
  echo "  no terminal profiles found, skipping."
  exit 0
fi

DEFAULT=""

for file in "$@"; do
  PROFILE="$(basename "$file" .terminal)"

  EXISTS=$(defaults read com.apple.Terminal "Window Settings" 2>/dev/null | grep -oE '"?'"$PROFILE"'"? = ')
  if [ -n "$EXISTS" ]; then
    echo "    profile '$PROFILE' already exists, skipping."
  else
    echo "    importing $(basename "$file")"
    open "$file"
  fi

  if [ -z "$DEFAULT" ]; then
    DEFAULT="$PROFILE"
  fi
done

echo "  Setting default Terminal profile: $DEFAULT"

defaults write com.apple.Terminal "Default Window Settings" -string "$DEFAULT"
defaults write com.apple.Terminal "Startup Window Settings" -string "$DEFAULT"

exit 0
