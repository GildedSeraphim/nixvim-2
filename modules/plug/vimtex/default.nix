{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    vimtex = {
      enable = true;
      texlivePackage = pkgs.texliveFull;
      settings = {
        compiler_method = "latexmk";
        toc_config = {
          split_pos = "vert topleft";
          split_width = 40;
        };
        view_method = "zathura";
        conceallevel = 1;
        tex_conceal = "abdmg";
      };
    };
  };

  programs.nixvim.keymaps =  [
    {
      mode = "n";
      key = "<leader>rs";
      action = ":Spectre<CR>";
      options = {
        desc = "Spectre toggle";
        silent = true;
      };
    }
  ];
}
