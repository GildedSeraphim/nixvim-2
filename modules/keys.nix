{
  programs.nixvim.config = {
    opts.conceallevel = 1;
    globals.tex_conceal = "abdmg";
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      # General maps
      {
        action = "<cmd>Telescope find_files<cr>";
        key = "<leader>ff";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Ex<cr>";
        key = "<leader>pv";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = ":m '>+1<CR>gv=gv";
        key = "J";
        mode = "v";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = ":m '<-2<CR>gv=gv";
        key = "K";
        mode = "v";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "mzJ`z";
        key = "J";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "<C-d>zz";
        key = "<C-d>";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "<C-u>zz";
        key = "<C-u>";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "nzzzv";
        key = "n";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "Nzzzv";
        key = "N";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "\"_dP";
        key = "<leader>p";
        mode = "x";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "\"_dP";
        key = "<leader>p";
        mode = "x";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
        key = "<leader>s";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "<cmd>!chmod +x %<CR>";
        key = "<leader>x";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        action = "<cmd>noh<CR>";
        key = "<leader>q";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
    ];
    extraConfigLua = ''
      function ToggleLineNumber()
      if vim.wo.number then
        vim.wo.number = false
      else
        vim.wo.number = true
          vim.wo.relativenumber = false
          end
          end

          function ToggleRelativeLineNumber()
          if vim.wo.relativenumber then
            vim.wo.relativenumber = false
          else
            vim.wo.relativenumber = true
              vim.wo.number = false
              end
              end

              function ToggleWrap()
              vim.wo.wrap = not vim.wo.wrap
              end
    '';
  };
}
