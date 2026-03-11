local aucmd = vim.api.nvim_create_autocmd
-- highlight Yanked
aucmd({ 'TextYankPost' }, {
  desc = 'Highlight when yanked',
  group = vim.api.nvim_create_augroup('highlight yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [q]uit quickfix/help/manual/lspinfo
aucmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'man', 'lspinfo' },
  callback = function()
    vim.keymap.set('n', 'q', '<C-w>c', { buffer = true })
  end,
})

--go to cursor posion where you leave last time
aucmd({ 'BufReadPost' }, {
  desc = 'Go to the cursorline left last time',
  pattern = '*',
  callback = function()
    local pos = vim.fn.line('\'"')
    if pos > 0 and pos <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
})

if pcall(require, 'conform') then
  aucmd({ 'BufWritePre' }, {
    pattern = '*',
    callback = function(args)
      require('conform').format({ bufnr = args.buf })
    end,
  })
end

--session manager
--by mini.sessions
if vim.fn.argc() == 0 and pcall(require, 'mini.sessions') then
  local session = require('mini.sessions')
  local function cwd_session_name()
    return vim.fn.getcwd():gsub('[/\\]', '-'):gsub(':', '-')
  end
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
