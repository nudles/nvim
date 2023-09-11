local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

autocmd("BufWritePost", {
  pattern = {"*.h", "*.cpp", "*.lua"},
  callback = function()
    if (vim.g.rsync_dir)
    then
    -- relative path of the editing file to the working space
      local relative_path = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
      vim.fn.system("rsync " .. relative_path .. ' dev49:' .. vim.g.rsync_dir .. relative_path)
    -- vim.fn.system
    end
  end,
})

local g = vim.g
g.mapleader = ","
g.loaded_python3_provider=1
g.loaded_node_provider=1

g.clipboard = {
  name = 'myClipboard',
  copy = {
    ['+'] = 'clipboard-provider copy',
    ['*'] = 'clipboard-provider copy',
  },
  paste = {
    ['+'] = 'clipboard-provider paste',
    ['*'] = 'clipboard-provider paste',
  },
}

-- change the color of diff, ref :help hl-DiffAdd
vim.cmd "highlight DiffAdd    term=bold         ctermbg=darkgreen ctermfg=white    cterm=bold guibg=DarkGreen  guifg=White    gui=bold"
vim.cmd "highlight DiffText   term=reverse,bold ctermbg=red       ctermfg=yellow   cterm=bold guibg=DarkRed    guifg=yellow   gui=bold"
vim.cmd "highlight DiffChange term=bold         ctermbg=black     ctermfg=white    cterm=bold guibg=Black      guifg=White    gui=bold"
vim.cmd "highlight DiffDelete term=none         ctermbg=darkblue  ctermfg=darkblue cterm=none guibg=DarkBlue   guifg=DarkBlue gui=none"

vim.opt.relativenumber = true                   -- set relative numbered lines

