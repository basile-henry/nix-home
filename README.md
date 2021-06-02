# My nix home-manager setup

## Quick setup

For NixOS:
```bash
git clone git@github.com:basile-henry/nix-home.git ~/.config/nixpkgs/

NIXOS=21.05
nix-channel --add "https://nixos.org/channels/nixos-$NIXOS" nixos
nix-channel --add "https://nixos.org/channels/nixos-$NIXOS" nixpkgs
nix-channel --add "https://nixos.org/channels/nixos-unstable" nixpkgs-unstable
nix-channel --add "https://github.com/nix-community/home-manager/archive/release-$NIXOS.tar.gz" home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```

For non-NixOS (for some reason only the root channels are used by nix-env/home-manager in the default NIX_PATH):
```bash
git clone git@github.com:basile-henry/nix-home.git ~/.config/nixpkgs/

NIXOS=21.05
sudo $(which nix-channel) --add "https://nixos.org/channels/nixos-$NIXOS" nixos
sudo $(which nix-channel) --add "https://nixos.org/channels/nixos-$NIXOS" nixpkgs
sudo $(which nix-channel) --add "https://nixos.org/channels/nixos-unstable" nixpkgs-unstable
sudo $(which nix-channel) --add "https://github.com/nix-community/home-manager/archive/release-$NIXOS.tar.gz" home-manager
sudo $(which nix-channel) --update

nix-shell '<home-manager>' -A install
```
