return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jdtls = {},
                vtsls = {
                    settings = {
                        typescript = {
                            tsserver = {
                                maxTsServerMemory = 8192,
                            },
                        },
                    },
                },
            },
            setup = {
                jdtls = function() return true end,
            },
        },
    },
}
