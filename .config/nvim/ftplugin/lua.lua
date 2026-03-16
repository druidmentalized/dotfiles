vim.keymap.set("n", "<leader>cx", function() vim.cmd("luafile %") end, { desc = "Execute current file" })
