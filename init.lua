require("config.lazy")
require("config.opt")
require("config.keymaps")



vim.g.clipboard = {
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

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 1 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})
