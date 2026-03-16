return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            preview = {
                enable = true,
                icon_provider = "mini",
            },
            markdown = {
                headings = {
                    enable = true,
                },
                tables = {
                    enable = true,
                },
                list_items = {
                    enable = true,
                },
            },
            hybrid_modes = { "n" },
        },
        keys = {
            { "<leader>mv", "<cmd>Markview Toggle<cr>", desc = "Markview Toggle" },
            { "<leader>ms", "<cmd>Markview splitToggle<cr>", desc = "Markview Split Toggle" },
            { "<leader>mh", "<cmd>Markview HybridToggle<cr>", desc = "Markview Hybrid Toggle" },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        enabled = false,
    },
}
