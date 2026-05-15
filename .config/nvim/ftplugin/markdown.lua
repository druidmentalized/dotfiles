vim.opt_local.wrap = false
vim.opt_local.spell = false

local wk = require("which-key")

wk.add({
    { "<leader>m", group = "markdown", icon = " " },

    { "<leader>j", group = "jupyter", icon = { icon = "󰺃 ", color = "yellow" } },

    { "<leader>jm", group = "molten", icon = "󰟕" },
    { "<leader>jmi", "<cmd>MoltenInit<cr>", desc = "Initialize Molten", icon = "󰁡 ", buffer = true },

    { "<leader>jr", group = "run", icon = "" },
    { "<leader>jrl", "<cmd>MoltenEvaluateLine<cr>", desc = "Run Line", icon = "", buffer = true, silent = true },
    { "<leader>jd", "<cmd>MoltenDelete<cr>", desc = "Delete Output", icon = "󰆴", buffer = true, silent = true },
    {
        "<leader>jre",
        function()
            vim.cmd("MoltenEvaluateOperator")
            vim.schedule(function() vim.api.nvim_feedkeys("ib", "n", false) end)
        end,
        desc = "Run Current Cell",
        icon = " ",
        buffer = true,
        silent = true,
    },
    {
        "<leader>jrv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        desc = "Run Selection",
        mode = "v",
        icon = " ",
        buffer = true,
    },
})
