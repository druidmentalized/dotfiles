return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1001,
        opts = {
            rocks = { "dkjson" },
        },
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
    },
    {
        "GCBallesteros/jupytext.nvim",
        lazy = false,
        opts = {
            custom_language_formatting = {
                python = {
                    extension = "md",
                    style = "markdown",
                    force_ft = "markdown",
                },
            },
        },
    },
    {
        "jmbuhr/otter.nvim",
        opts = { buffers = { set_filetype = true } },
    },
}
