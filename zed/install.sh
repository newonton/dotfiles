#!/usr/bin/env bash
#
# install zed config and cli.

if test -d "/Applications/Zed.app"
then

  if test -f "$HOME/.config/zed/settings.json" && test ! -L "$HOME/.config/zed/settings.json"
  then
    mv "$HOME/.config/zed/settings.json" "$HOME/.config/zed/settings.json.backup"
  fi

  if test ! -L "$HOME/.config/zed/settings.json"
  then
    mkdir -p "$HOME/.config/zed"
    ln -s "$ZSH/zed/settings.json" "$HOME/.config/zed/settings.json"
  fi

  if test ! -L "/usr/local/bin/zed"
  then
    sudo ln -s "/Applications/Zed.app/Contents/MacOS/cli" "/usr/local/bin/zed"
  fi

fi

exit 0
