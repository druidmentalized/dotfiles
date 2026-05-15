return {
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                preset = "enter",
                ["<CR>"] = { "fallback" },
                ["<Tab>"] = {
                    function(_) -- Made instead of ai-accept, because this is not recognizable function in blink.cmp
                        local copilot_ok, copilot = pcall(require, "blink-copilot")
                        if copilot_ok and copilot.accept_suggestion then
                            if copilot.accept_suggestion() then return true end
                        end
                    end,
                    "select_and_accept", -- Accept selected blink.cmp item
                    "snippet_forward", -- Jump forward in snippet
                    "fallback", -- Normal Tab
                },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
        },
    },
}
