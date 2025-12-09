{
  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
    settings = {
      disable_filetype = [
        "TelescopePrompt"
      ];
      fast_wrap = {
        end_key = "$";
        map = "<M-e>";
      };
    };
  };
}
