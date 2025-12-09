{ config, pkgs, lib, ... }:

{
  # Enable lualine plugin in NixVim
  programs.nixvim.plugins.lualine.enable = true;

  # Optional: you can add extra configuration for lualine here
  programs.nixvim.plugins.lualine.options = {
    theme = "gruvbox";
    sectionSeparators = { left = ""; right = ""; };
    componentSeparators = { left = ""; right = ""; };
  };
}

