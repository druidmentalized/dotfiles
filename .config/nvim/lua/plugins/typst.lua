return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then table.insert(opts.ensure_installed, "typst") end
        end,
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                tinymist = {
                    settings = {
                        exportPdf = "onSave",
                        formatterMode = "typstyle",
                    },
                },
            },
        },
    },

    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "0.3.*",
        build = function() require("typst-preview").update() end,
        opts = {
            open_cmd = "open %s",
        },
        keys = {
            { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle Typst Preview" },
        },
    },
}
