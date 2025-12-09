{
  description = "My standalone NixVim config as a Home Manager module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux"; # adjust if needed
      pkgs = import nixpkgs { inherit system; };
    in
    {
      homeManagerModule =
        { config, pkgs, ... }:
        {
          imports = [
            nixvim.homeManagerModules.nixvim # import the official NixVim module
            ./modules/default.nix # your config
          ];
        };
    };
}
