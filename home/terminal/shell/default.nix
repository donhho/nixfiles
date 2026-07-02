{ config, pkgs, ... }:

{
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      
      historyControl = [ "ignoreboth" ];
      
      bashrcExtra = ''
        # check the window size after each command and update LINES and COLUMNS
        shopt -s checkwinsize
      '';

      shellAliases = {
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        fgrep = "fgrep --color=auto";
        egrep = "egrep --color=auto";
        
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";
      };
    };
 
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zoxide = { enable = true; };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    btop = {
      enable = true;

      settings = {
        color_theme = "vague";
        theme_background = true;
      };
    };
  };

  home.packages = with pkgs; [
    bat
    curl
    fd
    ripgrep
    tree
    tldr
    unzip
    wget
    wl-clipboard
    zip
  ];

  xdg.configFile."btop/themes/vague.theme".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixfiles/config/btop/themes/vague.theme";
}
