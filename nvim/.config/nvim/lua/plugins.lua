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
}

local extra_tools = {
    "clang-format",
    "stylua",
    "astro",
    "tailwindcss",
    "tex-fmt",
    "oxfmt",
    "beautysh",
}

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, extra_tools)

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
    { src = "https://github.com/wsdjeg/picker.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/kawre/neotab.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/OXY2DEV/markview.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
    { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/olimorris/persisted.nvim" },
    { src = "https://github.com/toppair/peek.nvim" },
})

require("peek").setup({
    auto_load = true, -- Carga el preview automáticamente al abrir un markdown
    close_on_bwrite = true, -- Cierra el preview al guardar el archivo
    syntax = true, -- Habilita resaltado de sintaxis
    theme = "dark", -- Tema del preview
    update_on_change = true,
})

vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

vim.keymap.set("n", "<leader>mp", "<cmd>PeekOpen<CR>", { desc = "Abrir Markdown Preview" })

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
-- vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_method = "skim"

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
        astro = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        css = { "prettier" },
        rust = { "rustfmt" },
        tex = { "tex-fmt" },
        latex = { "tex-fmt" },
        markdown = { "oxfmt" },
        md = { "oxfmt" },
        zsh = { "beautysh" },
    },
    formatters = {
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

require("persisted").setup({
    save_dir = vim.fn.expand("~/.local/share/nvim/sessions/"),
    autosave = true,
    autoload = true,
    on_autoload_no_session = function()
        vim.notify("No session loaded")
    end,
    follow_working_directory = true,
    allowed_dirs = nil,
    ignored_dirs = nil,
    ignored_filetypes = { "gitcommit", "gitrebase" },
})

local cmp = require("blink.cmp")
cmp.build():wait(6000)
cmp.setup({
    signature = { enabled = true },
})

vim.cmd.colorscheme("tokyonight-night")

require("markview").setup({
    preview = {
        icon_provider = "devicons",
    },
})
