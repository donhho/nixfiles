{ pkgs, ... }:

{
  home.packages = with pkgs; [
    geist-font
    nerd-fonts.geist-mono
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
}

