local git_editor_files = { "COMMIT_EDITMSG", "MERGE_MSG", "TAG_EDITMSG", "git-rebase-todo" }

local function is_git_editor()
    for _, arg in ipairs(vim.fn.argv()) do
        if vim.tbl_contains(git_editor_files, vim.fs.basename(arg)) then return true end
    end
    return false
end

return {
    {
        "linw1995/nvim-mcp",
        build = "cargo install --path .",
        event = "VeryLazy",
        cond = function() return not is_git_editor() end,
        opts = {},
    },
}
