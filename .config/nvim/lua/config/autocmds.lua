local path = vim.fn.stdpath("config") .. "/autocmds"

for name, type in vim.fs.dir(path) do
    if type == "file" and name:match("%.lua$") then
        local autocmd_file = path .. "/" .. name
        local ok, err = pcall(dofile, autocmd_file)
        if not ok then
            vim.notify("Error loading autocmds from " .. autocmd_file .. ": " .. err, vim.log.levels.ERROR)
        end
    end
end
