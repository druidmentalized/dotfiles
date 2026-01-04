return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = { style = "duskfox", transparent = true },
      })
      vim.cmd("colorscheme duskfox")

      local hl = vim.api.nvim_set_hl
      -- Hex Palette: Purple (#bb9af7), Mint (#73daca), Darker Purple (#565f89)

      hl(0, "SnacksDashboardIcon", { fg = "#73daca" }) -- Forced to Mint

      -- Changing this to Purple to match your headers
      hl(0, "SnacksDashboardKey", { fg = "#bb9af7", bold = true })

      hl(0, "SnacksDashboardStartup", { fg = "#73daca", italic = true }) -- Forced to Mint

      hl(0, "SnacksDashboardHeader", { fg = "#bb9af7", bold = true })
      hl(0, "SnacksDashboardTitle", { fg = "#bb9af7", bold = true })
      hl(0, "SnacksDashboardDesc", { fg = "#bb9af7" })

      hl(0, "NoiceCmdline", { fg = "#bb9af7" }) -- Text
      hl(0, "NoiceCmdlineIcon", { fg = "#73daca" }) -- Icon (:) in Mint
      hl(0, "NoiceCmdlinePrompt", { fg = "#bb9af7", bold = true })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "duskfox" },
  },
}
