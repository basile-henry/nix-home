# My nix home-manager setup

## Quick setup

For NixOS:
```bash
git clone git@github.com:basile-henry/nix-home.git ~/.config/nixpkgs/

NIXOS=22.11
nix-channel --add "https://nixos.org/channels/nixos-$NIXOS" nixos
nix-channel --add "https://nixos.org/channels/nixos-$NIXOS" nixpkgs
nix-channel --add "https://nixos.org/channels/nixos-unstable" nixpkgs-unstable
nix-channel --add "https://github.com/nix-community/home-manager/archive/release-$NIXOS.tar.gz" home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```
