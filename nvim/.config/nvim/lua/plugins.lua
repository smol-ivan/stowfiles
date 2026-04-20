local servers = { "clangd", "lua_ls", "basedpyright", "gopls", "rust_analyzer" }
local ensure_installed = servers
vim.list_extend(ensure_installed, {
    "clang-format",
    "stylua",
    "astro",
    "tailwindcss",
})

vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/saghen/blink.cmp" },
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
})

require("neotab").setup()

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = {},
        c = { "clang_format" },
        cpp = { "clang_format" },
        astro = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        css = { "prettier" },
        rust = { "rustfmt" },
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

require("oil").setup({
    columns = { "permissions", "icon" },
    view_options = { show_hidden = true },
})

require("mini.pick").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.ai").setup()

require("lualine").setup()

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

require("blink.cmp").setup({})

vim.cmd.colorscheme("tokyonight-night")

require("markview").setup({
    preview = {
        icon_provider = "devicons",
    },
})
