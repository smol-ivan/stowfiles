{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;

    settings = {
      vim.keymaps = [
        {
          key = "<leader>,";
          mode = "n";
          silent = true;
          action = ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
        }
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = ":Oil<CR>";
        }
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

        # --- Quarto Keymaps ---
        {
          key = "<leader>qp";
          mode = "n";
          silent = true;
          action = "<cmd>QuartoPreview<CR>";
        }
        {
          key = "<leader>qc";
          mode = "n";
          silent = true;
          action = "<cmd>QuartoClosePreview<CR>";
        }
        {
          key = "<localleader>rc";
          mode = "n";
          silent = true;
          action = ":lua require('quarto.runner').run_cell()<CR>";
        }
        {
          key = "<localleader>ra";
          mode = "n";
          silent = true;
          action = ":lua require('quarto.runner').run_above()<CR>";
        }
        {
          key = "<localleader>rA";
          mode = "n";
          silent = true;
          action = ":lua require('quarto.runner').run_all()<CR>";
        }
        {
          key = "<localleader>rl";
          mode = "n";
          silent = true;
          action = ":lua require('quarto.runner').run_line()<CR>";
        }
        {
          key = "<localleader>r";
          mode = "v";
          silent = true;
          action = ":lua require('quarto.runner').run_range()<CR>";
        }
      ];

      vim.options = {
        scrolloff = 10;
      };
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
        sql.enable = true;
        toml.enable = true;
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
        # name = "gruber-darker";
        name = "gruvbox";
        style = "dark";
      };

      vim.lsp.trouble.enable = true;
      vim.utility.motion.flash-nvim.enable = true;

      vim.autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = false;
        setupOpts = {
          completion = {
            documentation = {
              # Desactiva la ventana flotante de documentación automática al escribir
              auto_show = false;
              # Mantiene la documentación oculta tras retrasos
              auto_show_delay_ms = 500;
            };
          };
          keymap = {
            # Usa el preset predeterminado
            preset = "default";
            # Mapea un atajo para alternar (toggle) la ventana de documentación en el menú de autocompletado
            "<C-k>" = [
              "show_documentation"
              "hide_documentation"
              "fallback"
            ];
          };
        };
      };

      vim.binds.cheatsheet.enable = true;

      vim.visuals.fidget-nvim = {
        enable = true;
      };

      vim.formatter = {
        conform-nvim.enable = true;
      };
      vim.utility.oil-nvim = {
        enable = true;
        gitStatus.enable = true;
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

      vim.treesitter.enable = true;

      # --- Plugins manuales (no soportados nativamente por nvf) ---
      vim.extraPlugins = with pkgs.vimPlugins; {
        # 1. otter.nvim: Dependencia de quarto para proveer soporte LSP embebido dentro de los code chunks
        otter-nvim = {
          package = otter-nvim;
          setup = "require('otter').setup()";
        };

        # 2. Code Runner: vim-slime
        # Permite enviar celdas/bloques de código a una terminal integrada de Neovim, tmux, etc.
        # Otras alternativas comunes en Neovim son:
        #   - 'molten-nvim' (estilo Jupyter Notebook interactivo con outputs y gráficos directos en Neovim)
        #   - 'iron.nvim' (REPL interactivo integrado en splits de Neovim)
        vim-slime = {
          package = vim-slime;
          setup = ''
            -- Configura slime para enviar código a una terminal integrada de Neovim
            vim.g.slime_target = "neovim"
            vim.g.slime_no_mappings = 1
          '';
        };

        # 3. quarto-nvim: Herramientas para documentos Quarto (.qmd)
        quarto-nvim = {
          package = quarto-nvim;
          after = [
            "otter-nvim"
            "vim-slime"
          ];
          setup = ''
            require('quarto').setup({
              debug = false,
              closePreviewOnExit = true,
              lspFeatures = {
                enabled = true,
                chunks = "curly",
                languages = { "r", "python", "julia", "bash", "html" },
                diagnostics = {
                  enabled = true,
                  triggers = { "BufWritePost" },
                },
                completion = {
                  enabled = true,
                },
              },
              codeRunner = {
                enabled = true,
                default_method = "slime", -- opciones: "slime", "molten", "iron"
                never_run = { "yaml" },
              },
            })
          '';
        };
      };
    };
  };
}
