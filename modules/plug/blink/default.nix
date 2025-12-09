{
  programs.nixvim.plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        sources.providers = {
         
        };
        sources.default = [
          "lsp"
          "path"
          "buffer"
        ];
        keymap.preset = "super-tab";
        appearance = {
          nerd_font_variant = "mono";
          use_nvim_cmp_as_default = true;
        };
        signature.enabled = true;
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
              semantic_token_resolution = {
                enabled = false;
              };
            };
          };
          documentation = {
            auto_show = true;
          };
        };
      };
    };

  };
}
