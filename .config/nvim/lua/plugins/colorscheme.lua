return {
  --  {
  --    "folke/tokyonight.nvim",
  --    lazy = false,
  --    priority = 1000,
  --    config = function()
  --      require("tokyonight").setup({
  --        style = "night",
  --        transparent = true,
  --        styles = {
  --          sidebars = "transparent",
  --          floats = "transparent",
  --        },
  --      })
  --      vim.cmd([[colorscheme tokyonight]])
  --    end,
  --  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          style = "duskfox",
          transparent = true,
        },
      })
      vim.cmd("colorscheme duskfox")
    end,
  },
}
