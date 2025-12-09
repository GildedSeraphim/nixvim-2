{ config, pkgs, lib, ... }:

{
  # Enable lualine plugin in NixVim
  programs.nixvim.plugins.lualine.enable = true;
  #programs.nixvim.plugins.treesitter.enable = true;

}

