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
    firefox
    chromium
    plasma-browser-integration
    spectacle
  ];
}
