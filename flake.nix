{
  description = "Standalone NixVim config as a Home Manager module";

  outputs = { self, nixpkgs, ... }: {
    # Expose the module in a clean way
    homeManagerModule = ./modules/nixvim.nix;

    # Optional: expose it through `homeManagerModules.default`
    homeManagerModules.default = ./modules/nixvim.nix;
  };
}

