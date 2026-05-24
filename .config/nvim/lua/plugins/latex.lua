return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "skim"

            vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_syntax_conceal_disable = 1

            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                out_dir = "build",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                options = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-synctex=1",
                    "-verbose",
                },
            }
        end,
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                texlab = {
                    settings = {
                        texlab = {
                            build = {
                                onSave = false,
                            },
                            forwardSearch = {
                                executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
                                args = { "%l", "%p", "%f" },
                            },
                            chktex = {
                                onOpenAndSave = false,
                            },
                        },
                    },
                },
            },
        },
    },
}
