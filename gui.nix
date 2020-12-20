{ config, lib, pkgs, ... }:

let unstable = import <nixpkgs-unstable> {};

    extensions = (with unstable.vscode-extensions; [
      bbenoist.Nix
      ms-python.python
      ms-vsliveshare.vsliveshare
      vscodevim.vim
      matklad.rust-analyzer
      alanz.vscode-hie-server
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "errorlens";
        publisher = "usernamehw";
        version = "3.2.4";
        sha256 = "0caxmf6v0s5kgp6cp3j1kk7slhspjv5kzhn4sq3miyl5jkrn95kx";
    }];
    vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    };
in
{
  imports = [
    ./program/alacritty.nix
    "${fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master"}/modules/vsliveshare/home.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
  home.packages = with pkgs; [
    unstable.discord
    slack
    signal-desktop
    vlc
    firefox
    chromium
    plasma-browser-integration
    spectacle
    zoom-us
    deluge
    gimp
    hexchat
    obs-studio

    vscode-with-extensions

    # Games
    steam
    mupen64plus
    unstable.sauerbraten

    # Music
    audacity
    zynaddsubfx
    jack2
    qjackctl
  ];
}
