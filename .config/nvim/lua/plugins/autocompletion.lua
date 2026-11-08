return {
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                preset = "enter",
                ["<CR>"] = { "fallback" },
                ["<Tab>"] = {
                    "select_and_accept", -- Accept selected blink.cmp item
                    "snippet_forward", -- Jump forward in snippet
                    "fallback", -- Normal Tab
                },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
        },
    },
}
