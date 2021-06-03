{ config, lib, pkgs, ... }:

let unstable = import <nixpkgs-unstable> {};

in
{
  imports = [
    ./program/alacritty.nix
    ./program/vscode.nix
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
