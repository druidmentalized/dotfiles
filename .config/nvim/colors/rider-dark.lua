-- Reset existing highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "rider-dark"

-- 1. RIDER DARK PALETTE
local blue = "#6C95EB" -- Keywords (public, return, const, class)
local purple = "#C191FF" -- Classes & Types (AuthService, Promise)
local teal = "#39CC9B" -- Functions (signup, toCreate)
local easterGreen = "#9ece6a" -- Strings ("STUDENT")
local white = "#BDBDBD" -- Variables (email, dto)
local grey = "#858585" -- Comments
local parameter = "#65C1CA" -- Parameters (dto, user)
local property = "#DCDCAA" -- Properties/Fields (userRepository)

-- Set background
-- local bg = "NONE" -- This is to make every background transparent

local bg_main = "NONE"
local bg_other = "#0f0f17"

local hl = vim.api.nvim_set_hl

-- 3. CORE UI (Transparent Main, Opaque Floats)
hl(0, "Normal", { fg = white, bg = bg_main })
hl(0, "SignColumn", { bg = bg_main }) -- Gutter matches terminal
hl(0, "LineNr", { fg = "#484d5b", bg = bg_main })
hl(0, "CursorLine", { bg = "#2b2d3e" }) -- Highlight current line
hl(0, "CursorLineNr", { fg = white, bold = true })

-- FLOATING WINDOWS (Opaque)
hl(0, "NormalFloat", { fg = white, bg = bg_other })
hl(0, "FloatBorder", { fg = purple, bg = bg_other })

-- STATUS LINES & SPLITS (Fixed "White Bar" Issue)
hl(0, "StatusLine", { fg = white, bg = bg_other }) -- Active status bar
hl(0, "StatusLineNC", { fg = grey, bg = bg_other }) -- Inactive status bar
hl(0, "WinSeparator", { fg = "#444444", bg = bg_main }) -- Split lines
hl(0, "WinBar", { fg = white, bg = bg_main })
hl(0, "WinBarNC", { fg = grey, bg = bg_main })

-- 4. SYNTAX: KEYWORDS & LOGIC (Blue)
hl(0, "@keyword", { fg = blue })
hl(0, "@keyword.function", { fg = blue })
hl(0, "@keyword.return", { fg = blue })
hl(0, "@keyword.coroutine", { fg = blue })
hl(0, "@conditional", { fg = blue })
hl(0, "@repeat", { fg = blue })
hl(0, "@include", { fg = blue })
hl(0, "@type.builtin", { fg = blue })

-- 5. SYNTAX: FUNCTIONS (Teal)
hl(0, "@function", { fg = teal })
hl(0, "@function.method", { fg = teal })
hl(0, "@function.call", { fg = teal })

-- 6. SYNTAX: CLASSES & TYPES (Purple)
hl(0, "@type", { fg = purple })
hl(0, "@constructor", { fg = purple })
hl(0, "@variable.member", { fg = white })
hl(0, "@property", { fg = white })

-- 7. SYNTAX: STRINGS & DATA
hl(0, "@string", { fg = easterGreen })
hl(0, "@constant", { fg = purple })
hl(0, "@number", { fg = "#B5CEA8" })

-- 8. SYNTAX: VARIABLES & PARAMETERS
hl(0, "@variable", { fg = white })
hl(0, "@variable.parameter", { fg = parameter }) -- Bright Cyan
hl(0, "@lsp.type.parameter", { fg = parameter })

-- 9. DASHBOARD (Restored "Violet + Blue" Vibe)
-- Matches the style from your earlier "Duskfox" screenshot
hl(0, "SnacksDashboardIcon", { fg = purple }) -- Mint/Teal Icons
hl(0, "SnacksDashboardKey", { fg = purple, bold = true }) -- Blue Keys (f, n, p)
hl(0, "SnacksDashboardHeader", { fg = purple, bold = true }) -- Violet Header
hl(0, "SnacksDashboardTitle", { fg = purple, bold = true }) -- Violet Titles
hl(0, "SnacksDashboardDir", { fg = grey }) -- Dimmed paths
hl(0, "SnacksDashboardFooter", { italic = true }) -- Mint Footer text
hl(0, "SnacksDashboardStartup", { fg = purple, italic = true }) -- Grey startup stats

-- 10. NOICE / CMDLINE
hl(0, "NoiceCmdlineIcon", { fg = teal })
hl(0, "NoiceCmdlinePrompt", { fg = purple, bold = true })
