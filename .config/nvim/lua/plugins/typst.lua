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
        version = "1.*",
        build = function() require("typst-preview").update() end,
        opts = {
            open_cmd = "open %s",
            port = 65058,
            dependencies_bin = {
                ["tinymist"] = vim.fn.expand("~/.local/share/nvim/mason/bin/tinymist"),
            },
        },
        keys = {
            { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle Typst Preview" },
        },
    },
}
