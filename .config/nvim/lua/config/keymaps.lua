local wk = require("which-key")

-- Handle Deletions
wk.add({
    { "<leader>|", hidden = true },
    { "<leader>-", hidden = true },
})

-- General Navigation & Splits
wk.add({
    -- Window Splits
    { "<leader>\\", "<cmd>vsplit<cr>", desc = "Split Vertical", icon = "󰤼" },
    { "<leader>-", "<cmd>split<cr>", desc = "Split Horizontal", icon = "󰤻" },

    -- Tmux/Pane Navigation (No leader)
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to Left Pane", icon = " " },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to Lower Pane", icon = " " },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to Upper Pane", icon = " " },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to Right Pane", icon = " " },

    -- System Utilities
    { "<leader>I", function() vim.cmd("Inspect") end, desc = "Inspect Under Cursor", icon = "" },

    -- Keep Register
    { "p", [["_dP]], desc = "Paste (Keep Register)", mode = "x", icon = "   " },
})

-- Snacks / Finder
local function snacks() return require("snacks") end

wk.add({
    -- Additional Find
    {
        "<leader>fH",
        function() snacks().picker.files({ cwd = "~", hidden = true }) end,
        desc = "Home Directory",
        icon = "󰋜",
    },
    {
        "<leader>fR",
        function() snacks().picker.files({ cwd = "/", hidden = true }) end,
        desc = "System Root",
        icon = "",
    },

    -- Search
    { "<leader>sg", function() snacks().picker.grep({ cwd = "~" }) end, desc = "Grep (Home)", icon = "󰋜" },
})
