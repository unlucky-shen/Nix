# Terminal Prompt
PS1='\[\e[33m\] \w\[\e[0m\]\n\[\e[33m\] ❯ \[\e[0m\]'

# Aliases
alias nixup='sudo nixos-rebuild switch --upgrade'
alias nixre='sudo nixos-rebuild switch'
alias hiscw='history -c && history -w'
alias listgen='sudo nix-env -p /nix/var/nix/profiles/system --list-generations'
alias delgen='sudo nix-env -p /nix/var/nix/profiles/system --delete-generations'
alias deloldgen='sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old'
alias delncg='sudo nix-collect-garbage -d'
alias tsesh='tmux list-sessions'
