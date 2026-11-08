-- Local theme checkout; fall back to LazyVim's default on machines without it
local rider_dir = "~/Projects/rider-theme.nvim"
local has_rider = vim.uv.fs_stat(vim.fn.expand(rider_dir)) ~= nil

return {
    {
        "druidmentalized/rider-theme.nvim",
        dir = rider_dir,
        cond = has_rider,
        priority = 1000,
        lazy = false,
        opts = {
            transparent = false,
        },
    },

    { "LazyVim/LazyVim", opts = { colorscheme = has_rider and "rider-islands-dark" or "tokyonight" } },
}
