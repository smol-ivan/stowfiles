local pack = require("pack")

-- vim.keymap.set("n", "<leader>pi", pack.install)
vim.keymap.set("n", "<leader>pu", pack.update)
vim.keymap.set("n", "<leader>pc", pack.clean)
-- vim.keymap.set("n", "<leader>ps", pack.sync)

-- vim.keymap.set("n", "<leader>pc", pack_clean)
vim.keymap.set("n", "<leader>e", ":Oil<CR>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>y", '"+y<CR>')
vim.keymap.set("v", "<leader>y", '"+y<CR>')

-- vim.keymap.set("x", "p", [["_dP"]])
-- vim.keymap.set({ "n", "v" }, "m", '"_d')
vim.keymap.set("v", "mm", '"_dd')

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")

vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end)

vim.keymap.set("n", "<leader>ss", function()
    require("persisted").save()
    vim.notify("Session saved")
end)

vim.keymap.set("n", "<leader>sl", function()
    require("persisted").load()
    vim.notify("Session loaded")
end)

vim.keymap.set("n", "<leader>sd", function()
    require("persisted").delete()
    vim.notify("Session deleted")
end)

vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>")
vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>")
vim.keymap.set("n", "<leader>lr", "<cmd>VimtexClean<CR>")

vim.keymap.set("i", "<C-k>", function()
    require("blink.cmp").signature.toggle()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ts", ":Themery<CR>")

local function toggle_diagnostics()
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.disable()
        print("Inline VText gone")
    else
        vim.diagnostic.enable()
        print("Inline VText arrives")
    end
end

vim.keymap.set("n", "<leader>tt", toggle_diagnostics)

vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//g<left><left>')

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>fs", telescope.lsp_document_symbols)
vim.keymap.set("n", "<leader>fw", telescope.lsp_workspace_symbols)
vim.keymap.set("n", "<leader>fr", telescope.lsp_references)
vim.keymap.set("n", "<leader>fd", telescope.lsp_definitions)

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions" })
