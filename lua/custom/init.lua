local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
     pattern = "*",
  command = "tabdo wincmd =",
})

-- auto sync the updated file to remote, e.g., dev49:~/dev/ce/
autocmd("BufWritePost", {
  pattern = {"*.h", "*.cpp", "*.lua"},
  callback = function()
    if (vim.g.rsync_remote)
    then
    -- relative path of the editing file to the working space
      local relative_path = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
      vim.fn.system("rsync " .. relative_path .. vim.g.rsync_remote .. relative_path)
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

g.snipmate_snippets_path = "~/.config/nvim/snippets"

vim.opt.relativenumber = true                   -- set relative numbered lines

g.editorconfig = false
