{ config, pkgs, ... }:

let
  tmuxConfig =
    "${config.home.homeDirectory}/nixfiles/config/tmux/tmux.conf";
in
{
  home.packages = with pkgs; [
    tmux
  ];

  xdg.configFile."tmux/tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink tmuxConfig;
}
