{ config, pkgs, ... }:

let
  neovimConfig =
    "${config.home.homeDirectory}/nixfiles/config/neovim";
in
{
  home.packages = with pkgs; [
    neovim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile."nvim/init.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${neovimConfig}/init.lua";

  xdg.configFile."nvim/nvim-pack-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink "${neovimConfig}/nvim-pack-lock.json";
}
