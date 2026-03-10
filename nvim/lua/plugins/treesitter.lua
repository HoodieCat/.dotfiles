local M = {}
-- for windows os
local powershell = vim.fn.has('win32') and 'powershell' or ''
M = {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  lazy = false,
  build = ':TSUpdate',
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    fold = { enable = true },
  },
}
return M
