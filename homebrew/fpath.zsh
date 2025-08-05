FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

if find "/opt/homebrew/share" -prune \( -perm -g+w -o -perm -o+w \) -print -quit | grep -q .; then
  chmod go-w "/opt/homebrew/share"
fi

if find "/opt/homebrew/share/zsh" \( -perm -g+w -o -perm -o+w \) -print -quit | grep -q .; then
  chmod -R go-w "/opt/homebrew/share/zsh"
fi
