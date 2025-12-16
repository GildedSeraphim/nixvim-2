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
    -- UI / borders
    ---------------------------------------------------------------------------
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = _border }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = _border }
    )

    vim.diagnostic.config({
      float = { border = _border },
    })

    -- still provided by nvim-lspconfig (not deprecated)
    require("lspconfig.ui.windows").default_options = {
      border = _border,
    }

    ---------------------------------------------------------------------------
    -- ZLS (use the one from $PATH / nix flake devShell)
    ---------------------------------------------------------------------------
    local util = require("lspconfig.util")

    if vim.fn.executable("zls") == 1 then
      vim.lsp.config("zls", {
        cmd = { "zls" },
        root_dir = util.root_pattern("build.zig", ".git"),
      })

      vim.lsp.enable("zls")
    end

    ---------------------------------------------------------------------------
    -- Generic server setup (replaces lspconfig[server].setup)
    ---------------------------------------------------------------------------
    if type(vim.g.nixvim_lsp_servers) == "table" then
      for server, config in pairs(vim.g.nixvim_lsp_servers) do
        config.capabilities =
          require("blink.cmp").get_lsp_capabilities(config.capabilities)

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end
  '';

}
