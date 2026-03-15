local opts = { noremap = true, silent = true }
local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohls<CR>', opts)
--diagnostic
map('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnositc [l]ocal list' })
map('n', '<leader>dt', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = '[D]iagnostic [T]oggle' })
map('n', ']d', function()
  vim.diagnostic.jump({ count = 2, float = true })
end, opts)
map('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, opts)
map('n', '<leader>df', function()
  vim.diagnostic.open_float()
end, { desc = '[d]iagnostic [f]loating' })
--terminal -> normal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
--buffer
map('n', '<S-l>', ':bnext<CR>', opts)
map('n', '<S-h>', ':bprevious<CR>', opts)
map('n', 'j', 'gj', { desc = '[j] as gj when wrapped' })
map('n', 'k', 'gk', { desc = '[k] as gk when wrapped' })
map('n', '<C-s>', '<cmd>write<CR>', { desc = 'Write' })
map('n', '<leader>qo', '<cmd>copen<CR>', { desc = 'quickfix' })
map('n', '<leader>bd', ':bdelete<CR>', { desc = '[B]uffer [D]elete' })
map('n', '<C-k>', '<C-w><c-+>', { desc = 'Increase height' })
map('n', '<C-j>', function()
  if vim.fn.winnr('$') ~= 1 and vim.fn.winheight(0) < (vim.o.lines - 3) then
    vim.cmd('resize' .. '-' .. vim.v.count1)
  end
end, { desc = 'Decrease height' })
map('n', '<c-l>', '<c-w><c->>', { desc = 'Increase width' })
map('n', '<c-h>', '<c-w><c-<>', { desc = 'Decrease width' })
--Tab
map('n', '[t', ':tabprevious<CR>', { desc = '[T]ab previous' })
map('n', ']t', ':tabNext<CR>', { desc = '[T]ab previous' })
map('n', '<leader>tn', ':tabnew<CR>', { desc = '[T]ab New' })
map('n', '<leader>tt', ':tabclose<CR>', { desc = '[T]ab [t]oggle' })
--utilities
map('n', '<leader>l', '<cmd>Lazy<CR>', { desc = '[L]azy.nvim' })
map('n', '<leader>m', '<cmd>Mason<CR>', { desc = '[M]ason Menu' })
map('n', '<leader>cc', function()
  local file_name = vim.fn.expand('%:p')
  if file_name then
    vim.fn.setreg('+', file_name)
  end
end)
local ok, flash = pcall(require, 'flash')
if ok then
  vim.keymap.set('o', 'r', function()
    flash.remote()
  end, { desc = '[R]emote select' })
  vim.keymap.set({ 'o', 'n', 'x' }, 'S', function()
    flash.treesitter()
  end, { desc = 'Treesitter FLash' })
end
