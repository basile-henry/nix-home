{ config, lib, pkgs, ... }:

{
  imports = [
    ./program/alacritty.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
  home.packages = with pkgs; [
    discord
    slack
    signal-desktop
    vlc
    firefox
    chromium
    plasma-browser-integration
    spectacle
    vscode
  ];
}
