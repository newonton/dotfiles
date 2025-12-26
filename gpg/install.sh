#!/bin/sh
#
# GPG
#
# This installs gpg keys from $ZSH/local

# Check for gpg
if ! command -v gpg >/dev/null 2>&1
then
  echo "  gpg not found, skipping gpg keys installation."
  exit 0
fi

if [ ! -d "$ZSH/local" ]
then
  echo "  no local directory with gpg keys, skipping."
  exit 0
fi

echo "  Installing GPG keys for you."

for key in "$ZSH/local/*.gpg" "$ZSH/local/*.asc"; do
  [ -f "$key" ] || continue

  gpg --import "$key"
done

exit 0
