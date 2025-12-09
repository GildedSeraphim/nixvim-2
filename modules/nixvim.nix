
{ config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    plugins.lualine.enable = true;
    plugins.treesitter.enable = true;

    # Add any config you want here...
  };
}
