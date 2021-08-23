
{ config, lib, pkgs, ... }:

let unstable = import <nixpkgs-unstable> {};

    vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = (with unstable.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-vsliveshare.vsliveshare
        ms-vscode-remote.remote-ssh
        ms-vscode.cpptools
        vscodevim.vim
        matklad.rust-analyzer
        haskell.haskell
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
          name = "errorlens";
          publisher = "usernamehw";
          version = "3.2.4";
          sha256 = "0caxmf6v0s5kgp6cp3j1kk7slhspjv5kzhn4sq3miyl5jkrn95kx";
        }
        {
          name = "language-haskell";
          publisher = "justusadam";
          version = "3.3.0";
          sha256 = "1285bs89d7hqn8h8jyxww7712070zw2ccrgy6aswd39arscniffs";
        }
      ];
    };
in
{
  home.packages = [
    vscode-with-extensions
  ];
}
