vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/saghen/blink.lib" },
    { src = "https://github.com/saghen/blink.compat" },
})

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
})

require("blink.compat").setup({})
