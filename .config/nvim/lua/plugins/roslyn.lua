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
        -- Server settings go through vim.lsp.config (roslyn.nvim opts only take plugin options).
        -- Set in init so they exist before the plugin's `vim.lsp.enable("roslyn")` runs.
        init = function()
            vim.lsp.config("roslyn", {
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                    },
                },
            })
        end,
        opts = {
            ignore_target = function(target) return target:match("backend/") ~= nil end,
        },
    },
}
