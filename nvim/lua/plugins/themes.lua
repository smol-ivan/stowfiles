vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/thimc/gruber-darker.nvim" },
    { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/rose-pine/neovim", variant = "main", name = "rose-pine" },
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/EdenEast/nightfox.nvim" },
    { src = "https://github.com/everviolet/nvim" },
    { src = "https://github.com/sainnhe/gruvbox-material" },
    { src = "https://github.com/bluz71/vim-moonfly-colors", name = "moonfly" },
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/zaldih/themery.nvim" },
})

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
