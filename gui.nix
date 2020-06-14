{ config, lib, pkgs, ... }:

{
  imports = [
    ./program/alacritty.nix
    "${fetchTarball "https://github.com/msteen/nixos-vsliveshare/tarball/master"}/modules/vsliveshare/home.nix"
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

  # For VSCode Liveshare support
  services.vsliveshare.enable = true;
}
