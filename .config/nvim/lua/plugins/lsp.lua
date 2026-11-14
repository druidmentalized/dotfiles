-- Resolve the interpreter per projectr: <root>/.venv
local function python_venv_before_init(_, config)
    local python = config.settings.python or {}
    if python.pythonPath then return end

    local candidates = {}
    if config.root_dir then table.insert(candidates, vim.fs.joinpath(config.root_dir, ".venv", "bin", "python")) end
    if vim.env.VIRTUAL_ENV then table.insert(candidates, vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")) end

    for _, path in ipairs(candidates) do
        if vim.fn.executable(path) == 1 then
            -- Mutate in place: client.settings is this same table, reassigning would not reach the server
            python.pythonPath = path
            config.settings.python = python
            return
        end
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = { before_init = python_venv_before_init },
                jdtls = {},
                vtsls = { enabled = false },
                tsc = {},
            },
            setup = {
                jdtls = function() return true end,
            },
        },
    },
}
