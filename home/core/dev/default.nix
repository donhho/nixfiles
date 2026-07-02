{ pkgs, ... }:

{
  home.packages = with pkgs; [
    llvmPackages.clang-unwrapped
    basedpyright
    nixd
    lua-language-server
    bash-language-server

    nodejs
    uv
  ];
}
