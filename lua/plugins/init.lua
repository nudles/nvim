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
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {  -- Normal mode (inside Telescope picker)
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },

        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f",  "--exclude", "build*/*", "--exclude", "contrib", "--exclude", "docs" }
          }
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
      require("nvim-tree").setup {
        update_focused_file = {
          enable = true,   -- Automatically update the tree when switching buffers
          update_cwd = false, -- Update the tree root directory to match the current buffer
          ignore_list = {}, -- List of buffers to ignore (optional)
        }
      }
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
  },
  {
    "nvim-lua/lsp-status.nvim",
    dependencies = {"neovim/nvim-lspconfig"},
    config = function()
      local lsp_status = require("lsp-status")

      lsp_status.config({
        status_symbol = " ",  -- Icon for LSP status
        indicator_errors = "",
        indicator_warnings = "",
        indicator_info = "",
        indicator_hint = "",
        indicator_ok = "",
        spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
      })

      lsp_status.register_progress()

      local lspconfig = require('lspconfig')
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Go to definition
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        -- Go to references
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- Go to implementation
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        -- Hover documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Signature help
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
        -- Rename symbol
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- Code actions
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        -- Show diagnostics
        vim.keymap.set("n", "<leader>da", vim.diagnostic.open_float, opts)
        -- Next/previous diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        lsp_status.on_attach(client)
      end


      -- Some arbitrary servers
      lspconfig.clangd.setup({
        handlers = lsp_status.extensions.clangd.setup(),
        init_options = {
          clangdFileStatus = true
        },
        on_attach = on_attach,
        capabilities = lsp_status.capabilities,
        root_dir = function(fname)
          local root = require("lspconfig.util").root_pattern("compile_commands.json")(fname)
          if root then
            local allowed_dirs = { "/src/", "/base/" }
            for _, dir in ipairs(allowed_dirs) do
              if fname:match(root .. dir) then
                return root
              end
            end
          end
          return nil  -- Prevent LSP from starting outside src/ and base/
        end,
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', "nvim-lua/lsp-status.nvim" },
    config = function()
      local function custom_os_icon()
        local os_name = vim.loop.os_uname().sysname
        local icons = {
          Darwin = '', -- Apple icon
          Linux = '',
          Windows = ''
        }
        return icons[os_name] or os_name
      end

      require("lualine").setup{
        -- Add LSP progress info to lualine
        sections = {
          lualine_c = {
            { "diagnostics" }, -- Shows error/warning/info counts
            { "filename" },    -- Displays the file name
            { "require('lsp-status').status()" }, -- Shows LSP indexing progress
          },
          lualine_z = {'location', custom_os_icon},
        },
      }
    end,
  },
  { "tpope/vim-fugitive" },
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() 
      require("bufferline").setup{}
    end,
  },
  {
    "easymotion/vim-easymotion",
    config = function()
      vim.g.EasyMotion_do_mapping = 0  -- Disable default mappings
      vim.g.EasyMotion_smartcase = 1   -- Enable smart case search

      -- Custom mappings
      vim.api.nvim_set_keymap("n", "<leader><leader>w", "<Plug>(easymotion-bd-w)", {})
      -- vim.api.nvim_set_keymap("n", "<leader><leader>f", "<Plug>(easymotion-bd-f)", {})
      -- vim.api.nvim_set_keymap("n", "<leader><leader>l", "<Plug>(easymotion-lineforward)", {})
      -- vim.api.nvim_set_keymap("n", "<leader><leader>j", "<Plug>(easymotion-j)", {})
      -- vim.api.nvim_set_keymap("n", "<leader><leader>k", "<Plug>(easymotion-k)", {})
    end,
  },
  {'akinsho/toggleterm.nvim', version = "*", 
    config = function()
      require("toggleterm").setup{
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        direction = 'horizontal' 
      }
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
	{
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	}
}
