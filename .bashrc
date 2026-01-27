# Alias 
alias v='nvim'
alias hiscw='history -c && history -w'
alias ls='eza --tree'
alias nrs='sudo nixos-rebuild switch'
alias lsg='sudo nix-env --list-generations -p /nix/var/nix/profiles/system'
alias dga='sudo nix-collect-garbage -d'
alias dgs='sudo nix-env -p /nix/var/nix/profiles/system --delete-generations'
alias ncg='sudo nix-collect-garbage'

# Starship
eval "$(starship init bash)"
