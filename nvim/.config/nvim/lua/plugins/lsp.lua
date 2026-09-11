vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
})

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

require("fidget").setup()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {},
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

for server, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end
