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

-- Find files in Home directory
vim.keymap.set("n", "<leader>fH", function()
  Snacks.picker.files({ cwd = "~", hidden = true })
end, { desc = "Find Files (Home)" })

-- Find files in System Root (/)
vim.keymap.set("n", "<leader>fR", function()
  Snacks.picker.files({ cwd = "/", hidden = true })
end, { desc = "Find Files (System Root)" })

-- Grep search in Home directory
vim.keymap.set("n", "<leader>sg", function()
  Snacks.picker.grep({ cwd = "~" })
end, { desc = "Grep (Home)" })
