{ config, lib, pkgs, ... }:

let monospace = "Hack";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.startup_mode = "Maximized";
      window.title = "Terminal";

      shell = {
        program = "bash";
        args = [ "-l" ];
      };

      font = {
        use_thin_strokes = true;
        normal.family = monospace;
        bold.family = monospace;
        italic.family = monospace;
      };
    };
  };
}
