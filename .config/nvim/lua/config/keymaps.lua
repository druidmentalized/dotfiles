-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Delete the old LazyVim defaults if they conflict (optional)
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>-")

-- New intuitive split keys
vim.keymap.set("n", "<leader>\\", "<cmd>vsplit<cr>", { desc = "Split Vertical" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "Split Horizontal" })

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Go to Left Pane" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Go to Lower Pane" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Go to Upper Pane" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Go to Right Pane" })

local Snacks

local function snacks()
  if not Snacks then
    Snacks = require("snacks")
  end
  return Snacks
end
-- Find files in Home directory
vim.keymap.set("n", "<leader>fH", function()
  snacks().picker.files({ cwd = "~", hidden = true })
end, { desc = "Find Files (Home)" })

-- Find files in System Root (/)
vim.keymap.set("n", "<leader>fR", function()
  snacks().picker.files({ cwd = "/", hidden = true })
end, { desc = "Find Files (System Root)" })

-- Grep search in Home directory
vim.keymap.set("n", "<leader>sg", function()
  snacks().picker.grep({ cwd = "~" })
end, { desc = "Grep (Home)" })

-- Paste without overwriting the register
vim.keymap.set("x", "p", [["_dP]])
--
-- TEMP: execute current Lua file (in Neovim Lua context)
vim.keymap.set("n", "<leader>cx", function()
  vim.cmd("luafile %")
end, { desc = "Run current Lua file" })

vim.keymap.set("n", "<leader>I", function()
  vim.cmd("Inspect")
end)
