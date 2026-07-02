{ ... }:

{
  imports = [
    ../../graphical
  ];

  home = {
    username = "don";
    homeDirectory = "/home/don";
  };

  programs.git.settings.user = {
    name = "Donovan Ho";
    email = "donhho@protonmail.com";
  };

  targets.genericLinux.enable = true;
}
