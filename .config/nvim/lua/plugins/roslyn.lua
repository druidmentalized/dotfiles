return {
    {
        "mason-org/mason.nvim",
        opts = function(_, opts)
            opts.registries = opts.registries or { "github:mason-org/mason-registry" }
            table.insert(opts.registries, "github:Crashdummyy/mason-registry")
        end,
    },

    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {
            config = {
                capabilities = vim.lsp.protocol.make_client_capabilities(),
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                    },
                },
            },
            exe = "roslyn",
            args = { "--stdio", "--logLevel=Information" },
            ignore_target = function(target) return target:match("backend/") ~= nil end,
        },
    },
}
