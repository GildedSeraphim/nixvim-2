{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim.plugins = {
    lsp-format = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        html = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        clangd = {
          enable = true;
        };
        nixd = {
          enable = true;
          settings =
            let
              flake = ''(builtins.getFlake "github:GildedSeraphim/.dotfiles)""'';
              flakeNixvim = ''(builtins.getFlake "github:GildedSeraphim/nixvim)""'';
            in
            {
              nixpkgs = {
                expr = "import ${flake}.inputs.nixpkgs { }";
              };
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options = {
                nixos.expr = ''${flake}.nixosConfigurations.grovetender.options'';
                nixvim.expr = ''${flakeNixvim}.packages.${pkgs.system}.default.options'';
              };
            };
        };
        markdown_oxide = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        terraformls = {
          enable = true;
        };
        texlab = {
          enable = true;
        };
        yamlls = {
          enable = true;
          settings = {
            schemaStore = {
              enable = false;
              url = "";
            };
          };
        };

      };
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          # Use LSP saga keybinding instead
          # K = {
          #   action = "hover";
          #   desc = "Hover";
          # };
          # "<leader>cw" = {
          #   action = "workspace_symbol";
          #   desc = "Workspace Symbol";
          # };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        # diagnostic = {
        #   "<leader>cd" = {
        #     action = "open_float";
        #     desc = "Line Diagnostics";
        #   };
        #   "[d" = {
        #     action = "goto_next";
        #     desc = "Next Diagnostic";
        #   };
        #   "]d" = {
        #     action = "goto_prev";
        #     desc = "Previous Diagnostic";
        #   };
        # };
      };
    };
  };

  programs.nixvim.extraConfigLua = ''
    ---------------------------------------------------------------------------
    -- LSP UI
    ---------------------------------------------------------------------------
    local border = "rounded"

    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = border })

    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

    vim.diagnostic.config({
      float = { border = border },
    })

    ---------------------------------------------------------------------------
    -- ZLS (custom binary from nix flake / devShell)
    ---------------------------------------------------------------------------
    if vim.fn.executable("zls") ~= 1 then
      return
    end

    -- Define the server
    vim.lsp.config("zls", {
      cmd = { "zls" },
      filetypes = { "zig" },
      root_dir = function(fname)
        return vim.fs.root(fname, { "build.zig", ".git" })
      end,
      single_file_support = true,
    })

    -- Explicitly start ZLS for Zig buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "zig",
      callback = function(args)
        vim.lsp.start({
          name = "zls",
          cmd = { "zls" },
          root_dir = vim.fs.root(args.buf, { "build.zig", ".git" }),
        })
      end,
    })
  '';

}
