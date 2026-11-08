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

-- Nvim 0.12's builtin :lsp has no log subcommand (nvim-lspconfig's :LspLog is gone)
if vim.fn.exists(":LspLog") ~= 2 then
    vim.api.nvim_create_user_command(
        "LspLog",
        function() vim.cmd("tabnew " .. vim.fn.fnameescape(vim.lsp.log.get_filename())) end,
        { desc = "Open the Nvim LSP client log" }
    )
end
