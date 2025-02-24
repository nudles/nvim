return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 
      'nvim-lua/plenary.nvim', 
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, 
    },

    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top", -- Moves the prompt to the top
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {  -- Insert mode (inside Telescope picker)
              ["<C-k>"] = actions.move_selection_next,
              ["<C-j>"] = actions.move_selection_previous,
            },
            n = {  -- Normal mode (inside Telescope picker)
              ["<C-k>"] = actions.move_selection_next,
              ["<C-j>"] = actions.move_selection_previous,
            },
          },
        },

        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },

      })

      telescope.load_extension("fzf")
    end,

  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end
  },

  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    "dhananjaylatkar/cscope_maps.nvim",
    config = function()
      require("cscope_maps").setup({ 
        cscope = {
          exec = 'gtags-cscope',
          picker = "telescope", -- "quickfix", "telescope", "fzf-lua" or "mini-pick"
        }
      })
    end,
  },
  -- {
  --   "ludovicchabant/vim-gutentags",
  --   config = function()
  --     vim.g.gutentags_modules = {"cscope_maps"} -- This is required. Other config is optional
  --     vim.g.gutentags_cscope_build_inverted_index_maps = 1
  --     vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/gutentags")
  --     vim.g.gutentags_file_list_command = "fd -e cpp -e h"
  --     vim.g.gutentags_ctags_tagfile = '.tags'
  --     vim.g.gutentags_project_root = {'.root', '.svn', '.git', '.hg', '.project'}
  --     -- vim.g.gutentags_trace = 1
  --   end,
  -- }

  -- Install Mason (LSP manager)
  { "williamboman/mason.nvim", config = true },

  -- Mason-LSPConfig (Bridge between Mason and LSPConfig)
  { "williamboman/mason-lspconfig.nvim", config = true },

  -- LSP Config (Neovim's built-in LSP client)
  { "neovim/nvim-lspconfig" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  }
}
