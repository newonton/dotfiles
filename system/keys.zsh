# Pipe my public key to my clipboard.
alias pubkey="cat $(cat $HOME/.ssh/config | grep -e "^IdentityFile" | cut -d " " -f 2  ).pub | pbcopy | echo 'Public key copied.'"
