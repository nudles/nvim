---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- hop
    ["<leader><leader>w"] = {":HopWord<CR>" },

    ["<C-n>"] = {"<C-d>", "Ctrl-n for page down"},

    -- resize window
    ["<C-S-k>"] = {":resize -2<CR>"},
    ["<C-S-j>"] = {":resize +2<CR>"},
    ["<C-S-l>"] = {":vertical resize -2<CR>"},
    ["<C-S-h>"] = {":vertical resize +2<CR>"},

    ["<S-l>"] = {":bnext<CR>", "next buf/tab"},
    ["<S-h>"] = {":bprevious<CR>", "prev buf/tab"},

    ["<S-q>"] = {":bdelete<CR>", "close buf/tab"},
  },
}

M.telescope = {
  n = {
    ["<leader>fw"] = { "<cmd> Telescope grep_string <CR>", "Live grep word under cursor" },
    ["<leader>ft"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fg"] = { "<cmd> lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"},
    ["<leader>fr"] = { "<cmd> lua require('telescope.builtin').resume()<CR>", "Resume previous search"},
    ["<leader>fs"] = { "<cmd> lua require('telescope.builtin').lsp_document_symbols()<CR>", "List symbols"},
  },
}

M.nvimtree = {
  plugin = true,
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}



return M
