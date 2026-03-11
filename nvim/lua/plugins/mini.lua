local M = {}
M = {
  'echasnovski/mini.nvim',
  version = false,
  event = 'VeryLazy',
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup({})
    require('mini.sessions').setup({})
    require('mini.pairs').setup({})
  end,
}
return M
