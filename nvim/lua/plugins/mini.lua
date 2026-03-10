local M = {}
M = {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup({})
    require('mini.pairs').setup()
    require('mini.sessions').setup({ autoread = true })
    -- sessions config
    local session = require('mini.sessions')
    --function to fetch the session name
    local function get_cwd_session()
      return vim.fn.getcwd():gsub('[/\\]', '-'):sub(4)
    end
    vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
      desc = 'Make-sessions',
      group = vim.api.nvim_create_augroup('Make-sessions', {}),
      callback = function()
        if vim.v.this_session == '' then
          local name = get_cwd_session()
          name = get_cwd_session()
          session.write(name, {})
        end
      end,
    })
  end,
}
return M
