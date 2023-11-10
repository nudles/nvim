-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },

  -- for diffview color
  DiffChange = {
        bg = '#007acc',  -- Background color for modified lines (blue)
        fg = '#ffffff'   -- Text color for modified lines (white)
  },

  DiffAdd = {
        bg = '#22863a',  -- Background color for added lines (green)
        fg = '#ffffff'   -- Text color for added lines (white)
  },

  DiffDelete = {
        bg = '#94151b',  -- Background color for deleted lines (red)
        fg = '#ffffff'   -- Text color for deleted lines (white)
  }

}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
