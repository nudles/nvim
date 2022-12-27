local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
 -- -- local lga_actions = require("telescope-live-grep-args.actions")
  -- extensions = {
  --   live_grep_args = {
  --     auto_quoting = true, -- enable/disable auto-quoting
  --     -- define mappings, e.g.
  --     -- mappings = { -- extend mappings
  --     --   i = {
  --     --     ["<C-k>"] = lga_actions.quote_prompt(),
  --     --     ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
  --     --   },
  --     -- },
  --     -- ... also accepts theme settings, for example:
  --     -- theme = "dropdown", -- use dropdown theme
  --     -- theme = { }, -- use own theme spec
  --     -- layout_config = { mirror=true }, -- mirror preview pane
  --   }
  -- },
}

telescope.load_extension("live_grep_args")
telescope.load_extension("recent_files")
