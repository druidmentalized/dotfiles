-- Reset existing hig
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "rider-dark"

-- RIDER DARK PALETTE
local blue = "#6C95EB"
local purple = "#C191FF"
local teal = "#39CC9B"
local orange = "#C9A26D"
local white = "#BDBDBD"
local grey = "#858585"
local cyan = "#65C1CA"
local easterGreen = "#9ece6a"
local rainee = "#B5CEA8"
local gray = "#444444"
local darkGray = "#2b2d3e"

local bg_main = "NONE"
local bg_other = "#0f0f17"

local hl = vim.api.nvim_set_hl

-- CORE UI (Transparent Main, Opaque Floats)
hl(0, "Normal", { fg = white, bg = bg_main })
hl(0, "SignColumn", { bg = bg_main })
hl(0, "LineNr", { fg = "#484d5b", bg = bg_main })
hl(0, "CursorLine", { bg = darkGray })
hl(0, "CursorLineNr", { fg = white, bold = true })

-- FLOATING WINDOWS & STATUS
hl(0, "NormalFloat", { fg = white, bg = bg_other })
hl(0, "FloatBorder", { fg = purple, bg = bg_other })
hl(0, "StatusLine", { fg = white, bg = bg_other })
hl(0, "StatusLineNC", { fg = grey, bg = bg_other })
hl(0, "WinSeparator", { fg = gray, bg = bg_main })

-- SYNTAX: KEYWORDS & LOGIC
hl(0, "@keyword", { fg = blue })
hl(0, "@conditional", { fg = blue })
hl(0, "@repeat", { fg = blue })
hl(0, "@type.builtin", { fg = blue })

-- SYNTAX: FUNCTIONS
hl(0, "@function", { fg = teal })
hl(0, "@function.method", { fg = teal })
hl(0, "@function.call", { fg = white })
hl(0, "@operator", { fg = teal })

-- SYNTAX: CLASSES, TYPES & TAGS (Forced to Purple)
hl(0, "@type", { fg = purple })
hl(0, "@constructor", { fg = purple })
hl(0, "@tag", { fg = teal }) -- HTML/JSX Tags (div, section, etc)
hl(0, "@tag.attribute", { fg = easterGreen })
hl(0, "@tag.builtin", { fg = purple }) -- Built-in tags
hl(0, "@tag.delimiter", { fg = purple }) -- Tag brackets (<, >)
hl(0, "@constant", { fg = purple })

-- SYNTAX: STRINGS
hl(0, "@string", { fg = orange })
hl(0, "@comment", { fg = easterGreen })
hl(0, "@number", { fg = rainee })

-- SYNTAX: VARIABLES & PARAMETERS
hl(0, "@variable", { fg = white })
hl(0, "@variable.member", { fg = cyan })
hl(0, "@variable.parameter", { fg = white })
hl(0, "@property", { fg = cyan })

-- DASHBOARD
hl(0, "SnacksDashboardIcon", { fg = purple })
hl(0, "SnacksDashboardKey", { fg = purple, bold = true })
hl(0, "SnacksDashboardHeader", { fg = purple, bold = true })
hl(0, "SnacksDashboardTitle", { fg = purple, bold = true })
hl(0, "SnacksDashboardStartup", { fg = purple, italic = true })

-- NOICE / CMDLINE
hl(0, "NoiceCmdlineIcon", { fg = purple })
hl(0, "NoiceCmdlinePrompt", { fg = purple, bold = true })

-- YAML
hl(0, "@property.yaml", { fg = purple, bold = true })
hl(0, "@field.yaml", { fg = easterGreen })
hl(0, "@label.yaml", { fg = teal, bold = true })

-- EXPLORER
hl(0, "SnacksPickerDirectory", { fg = purple, bold = true })
hl(0, "SnacksPickerFile", { fg = white })
hl(0, "SnacksPickerGitStatusModified", { fg = rainee })
hl(0, "SnacksPickerGitStatusUntracked", { fg = gray })

-- PICKER
hl(0, "SnacksPickerDir", { fg = purple })
hl(0, "SnacksPickerFile", { fg = white })
hl(0, "SnacksPickerIcon", { fg = purple })
