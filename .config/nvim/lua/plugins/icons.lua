local teal = "#39CC9B"

return {
    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            color_icons = false,
            override = {
                ["openapi.yaml"] = {
                    icon = "󰮄",
                    color = teal,
                    name = "OpenAPI",
                },
                ["openapi.yml"] = {
                    icon = "󰮄",
                    color = teal,
                    name = "OpenAPI",
                },
            },
        },
    },
}
