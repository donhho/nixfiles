{ config, ... }:

let  
  starshipConfig = 
    "${config.home.homeDirectory}/nixfiles/config/starship/starship.toml";
in
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink starshipConfig;
}
