local M = {}

function M.update()
    vim.pack.update()
end

function M.clean()
    local active = {}
    local unused = {}

    for _, plugin in ipairs(vim.pack.get()) do
        if plugin.active then
            active[plugin.spec.name] = true
        end
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active[plugin.spec.name] then
            table.insert(unused, plugin.spec.name)
        end
    end

    if vim.tbl_isempty(unused) then
        vim.notify("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)

    if choice == 1 then
        vim.pack.del(unused)
    end
end

return M
