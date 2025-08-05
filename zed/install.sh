#!/usr/bin/env bash
#
# install zed config and cli.

if test -d "/Applications/Zed.app"
then

  if test -f "$HOME/.config/zed/settings.json" && test ! -L "$HOME/.config/zed/settings.json"
  then
    mv "$HOME/.config/zed/settings.json" "$HOME/.config/zed/settings.json.backup"
  fi

  if test -L "$HOME/.config/zed/settings.json"
  then
    rm "$HOME/.config/zed/settings.json"
  fi

  mkdir -p "$HOME/.config/zed"
  ln -s "$HOME/.zedrc" "$HOME/.config/zed/settings.json"
  sudo ln -s "/Applications/Zed.app/Contents/MacOS/cli" "/usr/local/bin/zed"
fi

exit 0
