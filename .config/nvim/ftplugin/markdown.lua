vim.opt_local.wrap = false

local wk = require("which-key")

wk.add({
    -- Markdown
    { "<leader>m", group = "markdown", icon = " " },

    -- Jupyter Group
    { "<leader>j", group = "jupyter", icon = { icon = "󰺃", color = "yellow" } },

    -- Molten Management
    { "<leader>jm", group = "molten", icon = "󰟕" },
    { "<leader>jmi", ":MoltenInit<CR>", desc = "Initialize Molten", icon = "󰁡", buffer = true },

    -- Run
    { "<leader>jr", group = "run", icon = "" },
    { "<leader>jrl", ":MoltenEvaluateLine<CR>", desc = "Run Line", icon = "", buffer = true },
    { "<leader>jrd", ":MoltenDelete<CR>", desc = "Delete Output", icon = "󰆴", buffer = true },
    { "<leader>jre", ":MoltenEvaluateOperator<CR>", desc = "Run Current Cell", icon = "", buffer = true },

    {
        "<leader>jrv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        desc = "Run Selection",
        mode = "v",
        icon = "",
        buffer = true,
    },
})
