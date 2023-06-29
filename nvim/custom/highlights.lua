-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Cursor = {
    bg = "grey_fg",
  },
  -- CursorLine = {
  --   bg = "#3c3836",
  -- },
  Comment = {
    italic = true,
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
  Cursor = {
    bg = "grey_fg",
  },
}

return M
