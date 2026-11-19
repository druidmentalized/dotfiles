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
        lazy = false,
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
            choose_target = function(targets)
                local function depth(path) return select(2, path:gsub("/", "")) end
                local highest = targets[1]
                for _, target in ipairs(targets) do
                    if depth(target) < depth(highest) then highest = target end
                end
                return highest
            end,
        },
    },
}
