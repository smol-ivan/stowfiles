{

  programs.nvf = {
    enable = true;

    settings = {
      vim.keymaps = [
        {
          key = "<Esc>";
          mode = "n";
          silent = true;
          action = "<cmd>nohlsearch<CR>";
        }
        {
          key = "J";
          mode = "v";
          silent = true;
          action = ":m '>+1<CR>gv=gv";
        }
        {
          key = "K";
          mode = "v";
          silent = true;
          action = ":m '<-2<CR>gv=gv";
        }
        {
          key = "<leader>y";
          mode = [
            "n"
            "v"
          ];
          silent = true;
          action = "\"+y<CR>";
        }
        {
          key = "mm";
          mode = "v";
          silent = true;
          action = "'_dd";
        }
        # --- Atajos de Telescope (Símbolos, Definiciones, Búsqueda) ---
        {
          key = "<leader>f";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope find_files<CR>";
        }
        {
          key = "<leader>g";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope live_grep<CR>";
        }
        {
          key = "<leader>b";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope buffers<CR>";
        }
        {
          key = "<leader>h";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope help_tags<CR>";
        }

        # --- Navegación LSP con Telescope ---
        {
          key = "gd";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope lsp_definitions<CR>";
        }
        {
          key = "gr";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope lsp_references<CR>";
        }
        {
          key = "gi";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope lsp_implementations<CR>";
        }
        {
          key = "<leader>ws";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope lsp_workspace_symbols<CR>";
        }
        {
          key = "<leader>ds";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope lsp_document_symbols<CR>";
        }
        # {
        #   key = "<leader>h";
        #   mode = "n";
        #   silent = true;
        #   action = ":Pick help<CR>";
        # }
        # {
        #   key = "<leader>g";
        #   mode = "n";
        #   silent = true;
        #   action = ":Pick grep_live<CR>";
        # }
        # {
        #   key = "<leader>f";
        #   mode = "n";
        #   silent = true;
        #   action = ":Pick files<CR>";
        # }
        # {
        #   key = "<leader>b";
        #   mode = "n";
        #   silent = true;
        #   action = ":Pick buffers<CR>";
        # }
        {
          key = "<leader>tt";
          mode = "n";
          silent = true;
          action = "<cmd>lua if vim.diagnostic.is_enabled() then vim.diagnostic.disable() else vim.diagnostic.enable() end<CR>";
        }
        {
          key = "<leader>xx";
          mode = "n";
          silent = true;
          action = "<cmd>Trouble diagnostics toggle<cr>";
        }
        {
          key = "<leader>cs";
          mode = "n";
          silent = true;
          action = "<cmd>Trouble symbols toggle focus=false<cr>";
        }
      ];

      vim.viAlias = false;
      vim.vimAlias = true;

      vim.binds.whichKey.enable = true;

      vim.telescope.enable = true;
      vim.lsp = {
        enable = true;
        formatOnSave = true;
      };
      vim.diagnostics.enable = false;
      vim.diagnostics.config = {
        virtual_text = false;
        signs = false;
        underline = false;
      };

      vim.globals.mapleader = " ";
      vim.opts.tabstop = 4;
      vim.opts.shiftwidth = 4;

      vim.languages = {
        python.enable = true;
        rust.enable = true;
        clang.enable = true;
        json.enable = true;
        lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        terraform.enable = true;
        yaml.enable = true;
        java.enable = true;
        html.enable = true;
        go.enable = true;
        docker.enable = true;
      };
      vim.mini = {
        pick.enable = false;
        pairs.enable = true;
        surround.enable = true;
        ai.enable = true;
      };
      vim.terminal.toggleterm.enable = true;
      vim.terminal.toggleterm.lazygit.enable = true;
      vim.statusline.lualine.enable = true;
      vim.theme = {
        enable = true;
        name = "gruber-darker";
      };

      vim.lsp.trouble.enable = true;
      vim.utility.motion.flash-nvim.enable = true;

      vim.autocomplete.blink-cmp.enable = true;
      vim.autocomplete.blink-cmp.setupOpts.cmdline.keymap.preset = "default";
      vim.autocomplete.blink-cmp.setupOpts.keymap.preset = "default";
      vim.binds.cheatsheet.enable = true;

      vim.languages.tex = {
        enable = true;
        lsp.enable = true; # Activa texlab (LSP para LaTeX)
        treesitter.enable = true; # Highlighting avanzado
      };

      vim.visuals.fidget-nvim = {
        enable = true;
      };

      vim.formatter = {
        conform-nvim.enable = true;
      };
      vim.utility.oil-nvim = {
        enable = true;
        setupOpts = {
          columns = [
            "permissions"
            "icon"
          ];
          view_options = {
            show_hidden = true;
          };
        };
      };
      vim.visuals.nvim-web-devicons.enable = true;
    };
  };
}
