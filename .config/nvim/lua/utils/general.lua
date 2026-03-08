local M = {}

function M.get_os_name()
    local map = { darwin = "mac", linux = "linux", windows = "win" }
    local sysname = vim.uv.os_uname().sysname:lower()
    return map[sysname] or "unknown"
end

function M.project_name(root_dir) return (root_dir:gsub("[/\\:]", "%%")) end

function M.contains_in_dir(dir, passed)
    if not passed then return false end

    local filenames = type(passed) == "table" and passed or { passed }

    for _, filename in ipairs(filenames) do
        if vim.uv.fs_stat(vim.fs.joinpath(dir, filename)) then return true end
    end

    return false
end

return M
