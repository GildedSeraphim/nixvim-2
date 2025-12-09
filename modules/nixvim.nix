
{ config, lib, pkgs, ... }:

let
  # helper functions from lib
  optional = lib.lists.optional;
  foldlAttrs = lib.attrsets.foldlAttrs;

  # path to your plugins folder
  byName = ./plug;

  # read the directory and only import subdirs
  pluginImports =
    foldlAttrs
      (prev: name: type:
        prev ++ optional (type == "directory") [ byName + "/" + name ]
      )
      [ ]
      (builtins.readDir byName);
in
{
  # Home Manager imports
  imports =
    pluginImports
    ++ [
      ./autocommands.nix
      ./keys.nix
      ./sets.nix
    ];

  # Enable NixVim
  programs.nixvim.enable = true;

  # Optional: any other global settings you had
  nixpkgs.overlays = lib.attrValues self.overlays;
  nixpkgs.config.allowUnfree = true;
}
