{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    conform-nvim = {
      enable = true;
      autostart = true;
      settings = {
        formatters_by_ft = {
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
        zig = [ "zigfmt" ];
        odin = [ "odinfmt" ];
        nix = [ "alejandra" ]; # or "nixfmt" if you prefer the official one

        # other major languages
        rust = [ "rustfmt" ];
        go = [ "gofmt" "goimports" ];
        python = [ "ruff_format" ];
        lua = [ "stylua" ];
        sh = [ "shfmt" ];
        toml = [ "taplo" ];

        "_" = [ "trim_whitespace" "trim_newlines" ];
      };

      format_on_save = {
        timeout_ms = 1000;
        lsp_format = "fallback";
      };
    };
      };
    };

  extraPackages = with pkgs; [
    clang-tools    # clang-format
    alejandra
    rustfmt
    go
    gotools        # goimports
    ruff
    stylua
    shfmt
    taplo
  ];
}
