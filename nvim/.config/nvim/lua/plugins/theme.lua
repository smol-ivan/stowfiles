return {
    {
        "thimc/gruber-darker.nvim",
        priority = 1000,
        config = function()
            -- require("gruber-darker").setup({})
            -- vim.cmd.colorscheme("gruber-darker")
        end,
    },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    { "rose-pine/neovim", variant = "main", name = "rose-pine" },
    { "rebelot/kanagawa.nvim" },
    { "vague-theme/vague.nvim" },
    { "EdenEast/nightfox.nvim" },
    {
        "everviolet/nvim",
        name = "evergarden",
        opts = {
            editor = {
                transparent_background = false,
                sign = { color = "none" },
                float = {
                    color = "mantle",
                    solid_border = false,
                },
                completion = {
                    color = "surface0",
                },
            },
        },
    },
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_enable_italic = true
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
