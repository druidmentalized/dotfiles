local wk = require("which-key")

wk.add({
    {
        "<leader>cx",
        function() vim.cmd("luafile %") end,
        desc = "Execute current file",
        mode = "n",
        group = "markdown",
        icon = "",
        buffer = true,
    },
})
