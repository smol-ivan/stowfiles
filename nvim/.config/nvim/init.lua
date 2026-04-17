vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.cursorline = true
vim.o.scrolloff = 10

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.breakindent = true

vim.o.mouse = "a"
vim.o.undofile = true

vim.o.termguicolors = true

local servers = { "clangd", "lua_ls", "basedpyright", "gopls", "rust_analyzer" }
local ensure_installed = servers
vim.list_extend(ensure_installed, {
    "clang-format",
    "stylua",
    -- "ruff",
    -- "shfmt",
    -- "bashls",
    -- "beautysh",
    -- "texlab",
    -- "tex-fmt",
    "astro",
    -- "prettier",
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
    -- { src = "https://github.com/zaldih/themery.nvim"}
})

require("neotab").setup()

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = {
            -- "ruff_fix",
            -- "ruff_format",
            -- "ruff_organize_imports",
        },
        c = { "clang_format" },
        cpp = { "clang_format" },
        -- zsh = { "beautysh" },
        -- sh = { "shfmt" },
        -- bash = { "shfmt" },
        -- latex = { "tex-fmt" },
        -- tex = { "tex-fmt" },
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
-- require("mini.statusline").setup()
require("mini.ai").setup()

require("lualine").setup()

local function pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

require("blink.cmp").setup({})

vim.cmd.colorscheme("tokyonight-night")

-- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>e", ":Oil<CR>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", '"+y<CR>')
vim.keymap.set("v", "<leader>y", '"+y<CR>')

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")

-- FORMAT with conform
vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end)
