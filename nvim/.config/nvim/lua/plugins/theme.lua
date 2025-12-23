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
}
