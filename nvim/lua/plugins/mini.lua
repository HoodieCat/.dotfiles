local M = {}
M = {
  'echasnovski/mini.nvim',
  version = false,
  event = 'VeryLazy',
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup({})
    require('mini.pairs').setup({})

    local function cwd_session_name()
      return vim.fn.getcwd():gsub('[/\\]', '-'):gsub(':', '-')
    end
    local ok, sessions = pcall(require, 'mini.sessions')
    if ok then
      vim.keymap.set('n', '<leader>sl', function()
        sessions.read(sessions.get_latest())
      end, { desc = '[S]ession [L]atest' })
      vim.keymap.set('n', '<leader>sw', function()
        sessions.write(pwd)
      end, {})
    end

    if vim.fn.argc() == 0 and pcall(require, 'mini.sessions') then
      local session = require('mini.sessions')
      local session_group = vim.api.nvim_create_augroup('make-sessions', {})
      vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
        desc = 'Make-sessions',
        group = session_group,
        callback = function()
          local detected_sessions = session.detected
          for name, _ in pairs(detected_sessions) do
            if name == cwd_session_name() then
              session.write(name, { force = true })
            else
              session.write(cwd_session_name())
            end
          end
        end,
      })

      vim.api.nvim_create_autocmd('VimEnter', {
        desc = 'Read-Sessions',
        group = session_group,
        callback = function()
          local detected_sessions = session.detected
          for name, _ in pairs(detected_sessions) do
            if name == cwd_session_name() then
              vim.defer_fn(function()
                session.read(name, {})
              end, 100)
            end
          end
        end,
      })
    end
  end,
}
return M
