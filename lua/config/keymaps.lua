vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope search word under cursor' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Telescope resume previous search' })

vim.keymap.set('n', '<S-l>', "<cmd>bnext<CR>", { desc = 'right buf' })
vim.keymap.set('n', '<S-h>', "<cmd>bprevious<CR>", { desc = 'left buf' })
vim.keymap.set('n', '<S-q>', "<cmd>bdelete<CR>", { desc = 'close buf' })


vim.keymap.set('n', '<C-h>', "<C-w>h", { desc = 'to left window' })
vim.keymap.set('n', '<C-l>', "<C-w>l", { desc = 'to right window' })
vim.keymap.set('n', '<C-j>', "<C-w>j", { desc = 'to bottom window' })
vim.keymap.set('n', '<C-k>', "<C-w>k", { desc = 'to top window' })


vim.keymap.set('t', '<C-x>', vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc =  "Escape terminal mode" })




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

vim.keymap.set('n', '<leader>cb', "<cmd>lua CopyBufferNameToClipboard()<CR>", { desc = "copy buffer name"})
vim.keymap.set('n', '<leader>cf', "<cmd>lua CopyBufferPathToClipboard()<CR>", { desc = "copy buffer name"})
