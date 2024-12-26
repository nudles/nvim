---@type MappingsTable
local M = {}

function CopyBufferPathToClipboard()
  local path_name = vim.fn.expand "%:p"
  vim.fn.setreg("+", path_name)
  vim.cmd("echo 'Buffer path copied to clipboard: " .. path_name .. "'")
end

function CopyBufferNameToClipboard()
  local buffer_name = vim.fn.expand "%:t"
  vim.fn.setreg("+", buffer_name)
  vim.cmd("echo 'Buffer name copied to clipboard: " .. buffer_name .. "'")
end

function OpenCommitDiff()
  vim.fn.execute 'normal! 0"xyiw'
  vim.cmd "wincmd l"
  vim.fn.execute("DiffviewOpen " .. vim.fn.getreg "x" .. "^!")
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- hop
    -- ["<leader><leader>w"] = { ":HopWord<CR>" },

    ["<C-n>"] = { "<C-d>", "Ctrl-n for page down" },

    -- resize window
    ["<C-S-k>"] = { ":resize -2<CR>" },
    ["<C-S-j>"] = { ":resize +2<CR>" },
    ["<C-S-l>"] = { ":vertical resize -2<CR>" },
    ["<C-S-h>"] = { ":vertical resize +2<CR>" },

    ["<S-l>"] = { ":bnext<CR>", "next buf/tab" },
    ["<S-h>"] = { ":bprevious<CR>", "prev buf/tab" },

    ["<S-q>"] = { ":bdelete<CR>", "close buf/tab" },

    ["<leader>cb"] = { "<cmd>lua CopyBufferNameToClipboard()<CR>", "copy buffer name" },
    ["<leader>cf"] = { "<cmd>lua CopyBufferPathToClipboard()<CR>", "copy buffer absolute path" },

    -- open DiffView for the commit under the cursor in fugitive
    ["<leader>cd"] = { "<cmd>lua OpenCommitDiff()<CR>", "open commit diff" },


    ["<leader>fd"] = { ":set foldmethod=expr<CR>:set foldexpr=nvim_treesitter#foldexpr()<CR>", "set folding method"},
  },

  v = {
    -- formatting
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format {
          async = true,
          range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
          },
        }
      end,
      "LSP formatting",
    },
    ["kj"] = {"<Esc>"},
  },
  i = {
    ["kj"] = {"<Esc>"},
  }
}

M.telescope = {
  n = {
    ["<leader>fw"] = { "<cmd> Telescope grep_string <CR>", "Live grep word under cursor" },
    ["<leader>ft"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fg"] = { "<cmd> lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>" },
    ["<leader>fr"] = { "<cmd> lua require('telescope.builtin').resume()<CR>", "Resume previous search" },
    ["<leader>fs"] = { "<cmd> lua require('telescope.builtin').lsp_document_symbols()<CR>", "List symbols" },
    -- advanced_git_search
    ["<leader>gl"] = { "<cmd> lua require('telescope').extensions.advanced_git_search.search_log_content()<CR>", "Search logs" },
    ["<leader>gf"] = { "<cmd> lua require('telescope').extensions.advanced_git_search.search_log_content_file()<CR>", "Search logs of the current file" },
    ["<leader>gc"] = { "<cmd> lua require('telescope').extensions.advanced_git_search.diff_commit_file()<CR>", "Search commit messages for the current file" },
    ["<leader>gv"] = { "<cmd> lua require('telescope').extensions.advanced_git_search.diff_commit_line()<CR>", "Search commit messages for the selected lines" },
  },
}

M.nvimtree = {
  plugin = true,
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

return M
