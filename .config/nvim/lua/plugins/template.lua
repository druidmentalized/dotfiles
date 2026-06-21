local template_dir = "~/.config/nvim/templates"

local function dotted_path(root, root_dir, file_dir)
    local segments = { root }
    for seg in file_dir:sub(#root_dir + 2):gmatch("[^/]+") do
        table.insert(segments, seg)
    end
    return table.concat(segments, ".")
end

local namespace_resolvers = {
    cs = function(dir)
        local csproj = vim.fs.find(
            function(name) return name:match("%.csproj$") end,
            { upward = true, path = dir, type = "file" }
        )[1]

        if not csproj then return vim.fn.fnamemodify(dir, ":t") end
        return dotted_path(vim.fn.fnamemodify(csproj, ":t:r"), vim.fs.dirname(csproj), dir)
    end,
}

local function resolve_namespace()
    local resolver = namespace_resolvers[vim.bo.filetype]
    return resolver and resolver(vim.fn.expand("%:p:h")) or ""
end

return {
    {
        "glepnir/template.nvim",
        cmd = { "Template" },
        config = function()
            local template = require("template")
            template.setup {
                temp_dir = template_dir,
            }
            template.register("{{_namespace_}}", resolve_namespace)
        end,
    },
}
