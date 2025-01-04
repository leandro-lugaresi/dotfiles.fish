#!/usr/bin/env fish
mkdir -p ~/.gnupg
test -f ~/.gnupg/gpg-agent.conf || touch ~/.gnupg/gpg-agent.conf
test -f ~/.gnupg/gpg.conf || touch ~/.gnupg/gpg.conf

# set pinentry-tty
grep -q pinentry-program ~/.gnupg/gpg-agent.conf || echo "pinentry-program "(which pinentry-tty) >>~/.gnupg/gpg-agent.conf

# ask password every 24hours only
grep -q default-cache-ttl ~/.gnupg/gpg-agent.conf || echo "default-cache-ttl 86400" >>~/.gnupg/gpg-agent.conf
grep -q max-cache-ttl ~/.gnupg/gpg-agent.conf || echo "max-cache-ttl 86400" >>~/.gnupg/gpg-agent.conf

# Neovim support for gpg
grep -q allow-loopback-pinentry ~/.gnupg/gpg-agent.conf || echo allow-loopback-pinentry >>~/.gnupg/gpg-agent.conf
grep -q use-agent ~/.gnupg/gpg.conf || echo use-agent >>~/.gnupg/gpg.conf
grep -q "pinentry-mode loopback" ~/.gnupg/gpg.conf || echo "pinentry-mode loopback" >>~/.gnupg/gpg.conf

# reload agent
if command -qs gpp-connect-agent
    gpg-connect-agent reloadagent /bye
end
