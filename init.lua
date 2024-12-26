require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"


-- Enable the view option for all buffers
vim.api.nvim_create_autocmd({"BufWinLeave"}, {
    pattern = {"*.*"},
    command = "mkview"
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    pattern = {"*.*"},
    command = "silent! loadview"
})

-- for text folding 
require'nvim-treesitter.configs'.setup {
  fold = {
    enable = true
  }
}

-- not workding for all files; try <leader>fd to do it manually
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
