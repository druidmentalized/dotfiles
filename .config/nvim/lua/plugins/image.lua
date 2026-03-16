return {
    {
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        opts = {
            backend = "kitty",
            processor = "magick_cli",
            max_width_window_percentage = 80,
            max_height_window_percentage = 60,
            scale_factor = 1.0,
            window_overlap_clear_enabled = true,
            tmux_show_only_in_active_window = true,
        },
    },
    {
        "3rd/diagram.nvim",
        dependencies = { "3rd/image.nvim" },
        opts = {
            renderer_options = {
                mermaid = {
                    background = "transparent",
                    theme = "dark",
                    scale = 3,
                    width = 1400,
                },
            },
            events = {
                render_buffer = { "BufWinEnter", "TextChanged", "InsertLeave" },
                clear_buffer = { "BufLeave", "WinLeave" },
            },
        },
    },
}
