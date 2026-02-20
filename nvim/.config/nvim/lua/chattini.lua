vim.g.mapleader = " "

vim.g.have_nerd_font = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"

vim.o.showmode = false

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true

vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.opt.list = false
vim.opt.listchars = {
    trail = "·",
    tab = ">·",
    eol = "$",
}

-- vim.o.updatetime = 250
-- vim.o.timeoutlen = 300
-- vim.o.splitright = true
-- vim.o.splitbelow = true

vim.o.inccommand = "split"

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.termguicolors = true
vim.o.winborder = "rounded"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
map("n", "<leader>ts", ":Themery<CR>", opts, { desc = "[T]heme [S]witcher" })
map("v", "J", ":m '>+1<CR>gv=gv", opts, { desc = "Move block down" })
map("v", "K", ":m '<-2<CR>gv=gv", opts, { desc = "Move block up" })
map("n", "<leader>y", '"+y', opts, { desc = "Yank to file clboard" })
map("v", "<leader>y", '"+y', opts, { desc = "Yank to file clboard" })
-- map("n", "<leader>Y", '"+Y')
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

map("n", "<leader>w1", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<leader>w2", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<leader>w3", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<leader>w4", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<leader>w5", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<leader>wc", "<Cmd>BufferClose<CR>", opts)
map("n", "<Leader>e", ":NvimTreeToggle<CR>", opts, { desc = "Toggle nerdtree" })

map("n", "<leader>l", function()
    vim.opt.list = not vim.opt.list:get()
end, opts, { desc = "Toggle char" })

local function toggle_diagnostics()
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.disable()
        print("Inline VText gone")
    else
        vim.diagnostic.enable()
        print("Inline VText arrives")
    end
end

vim.keymap.set("n", "<leader>d", toggle_diagnostics, { desc = "Toggle Virtual Text" })

-- map("n", "<leader>e", "<Cmd>Ex<CR>", opts, { desc = "Open Explorer" })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.opt.guicursor = ""
