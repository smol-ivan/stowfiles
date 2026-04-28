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
