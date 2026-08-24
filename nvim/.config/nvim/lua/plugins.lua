local servers = {
    clangd = {},
    gopls = {},
    lua_ls = {},
    rust_analyzer = {},
    basedpyright = {
        settings = {
            basedpyright = {
                disableOrganizeImports = true,
                analysis = {
                    typeCheckingMode = "off",
                    diagnosticMode = "openFilesOnly",
                    autoSearchPaths = true,
                },
            },
        },
    },
    ruff = {
        init_options = {
            settings = { lint = { enable = true } },
        },
    },
    texlab = {},
    marksman = {},
    terraformls = {},
    ts_ls = {},
}

local extra_tools = {
    "clang-format",
    "stylua",
    "astro",
    "tailwindcss",
    "tex-fmt",
    "oxfmt",
    "beautysh",
    "prettier",
    "prettierd",
    "dockerfmt",
    "terraform",
}

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, extra_tools)

local parsers = {
    "astro",
    "bash",
    "c",
    "cpp",
    "css",
    "fish",
    "gitcommit",
    "go",
    "graphql",
    "html",
    "hyprlang",
    "java",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rasi",
    "regex",
    "rust",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
    "terraform",
    "dockerfile",
}

vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/saghen/blink.lib" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/kawre/neotab.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
    { src = "https://github.com/lervag/vimtex" },
    -- { src = "https://github.com/olimorris/persisted.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    { src = "https://github.com/thimc/gruber-darker.nvim" },
    { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/rose-pine/neovim", variant = "main", name = "rose-pine" },
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/EdenEast/nightfox.nvim" },
    { src = "https://github.com/everviolet/nvim" },
    { src = "https://github.com/sainnhe/gruvbox-material" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" },
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/zaldih/themery.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/folke/trouble.nvim" },
    { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
    { src = "https://github.com/saghen/blink.compat" },
})

require("obsidian").setup({
    picker = {
        name = "mini.pick",
    },
    legacy_commands = false,
    workspaces = {
        {
            name = "career - Dev",
            path = "/home/cherry/bone/aws/developer/notes/",
        },
    },
    templates = {
        folder = "_templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
    },
    preferred_link_style = "markdown",
})

require("trouble").setup({})

require("telescope").setup({})

require("gitsigns").setup({})

-- Main-branch nvim-treesitter ships queries under `runtime/queries/`,
-- which isn't on rtp by default. Prepend it so highlights/folds/indents
-- are visible to `vim.treesitter.start`.
local ts_init = vim.api.nvim_get_runtime_file("lua/nvim-treesitter/init.lua", false)[1]
if ts_init then
    vim.opt.runtimepath:prepend(vim.fn.fnamemodify(ts_init, ":h:h:h") .. "/runtime")
end

require("nvim-treesitter").install(parsers):wait(300000)

require("treesitter-context").setup({
    max_lines = 3,
    multiline_threshold = 1,
    min_window_height = 20,
})

vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    else
        vim.schedule(function()
            require("treesitter-context").go_to_context()
        end)
        return "<Ignore>"
    end
end, { desc = "Jump to upper context", expr = true })

vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
    options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}
vim.g.vimtex_compiler_latexmk_engines = {
    _ = "-pdf",
}
vim.g.vimtex_view_method = "zathura"
-- vim.g.vimtex_view_method = "skim"

require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
})

require("neotab").setup()

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        astro = { "prettierd", "prettier", stop_after_first = true },
        -- html = { "prettier" },
        html = { "oxfmt" },
        javascript = { "oxfmt" },
        css = { "oxfmt" },
        rust = { "rustfmt" },
        tex = { "tex-fmt" },
        latex = { "tex-fmt" },
        markdown = { "oxfmt" },
        md = { "oxfmt" },
        zsh = { "beautysh" },
        dockerfile = { "dockerfmt" },
        terraform = { "terraform" },
        tf = { "terraform" },
        yaml = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "oxfmt", "prettierd", stop_after_first = true },
        typescript = { "prettierd" },
    },
    formatters = {
        oxfmt = {
            prepend_args = { "-c", vim.fn.expand("~/.oxfmt.json"), "$FILENAME" },
        },
        stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
        },
        clang_format = {
            prepend_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, ColumnLimit: 80}" },
        },
    },
})

require("fidget").setup()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {},
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

local capabilities = require("blink.cmp").get_lsp_capabilities()

for server, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

require("oil").setup({
    columns = { "permissions", "icon" },
    view_options = { show_hidden = true },
})

require("mini.pick").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup()

require("lualine").setup()

-- require("persisted").setup({
--     save_dir = vim.fn.expand("~/.local/share/nvim/sessions/"),
--     autosave = true,
--     autoload = true,
--     on_autoload_no_session = function()
--         vim.notify("No session loaded")
--     end,
--     follow_working_directory = true,
--     allowed_dirs = nil,
--     ignored_dirs = nil,
--     ignored_filetypes = { "gitcommit", "gitrebase" },
-- })

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
    signature = {
        enabled = true,
    },
    completion = {
        documentation = {
            auto_show = false,
        },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "obsidian", "obsidian_new", "obsidian_tags" },
        providers = {
            obsidian = {
                name = "obsidian",
                module = "blink.compat.source",
                opts = { name = "obsidian" },
            },
            obsidian_new = {
                name = "obsidian_new",
                module = "blink.compat.source",
                opts = { name = "obsidian_new" },
            },
            obsidian_tags = {
                name = "obsidian_tags",
                module = "blink.compat.source",
                opts = { name = "obsidian_tags" },
            },
        },
        snippets = {
            opts = {
                friendly_snippets = false, -- sin friendly-snippets
                search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                global_snippets = { "global" }, -- archivos globales
                extended_filetypes = {},
                ignored_filetypes = {},
            },
        },
    },
})

require("blink.compat").setup({})

require("themery").setup({
    themes = {
        "gruber-darker",
        "oxocarbon",
        "gruvbox",
        "rose-pine",
        "kanagawa-wave",
        "kanagawa-dragon",
        "nightfox",
        "duskfox",
        "carbonfox",
        -- "evergarden-winter",
        -- "evergarden-fall",
        -- "evergarden-spring",
        "tokyonight-night",
        "tokyonight-moon",
        "tokyonight-storm",
        "moonfly",
        -- "bamboo",
        "catppuccin-mocha",
        "vague",
    },
    livePreview = true,
})

-- vim.cmd.colorscheme("tokyonight-night")
