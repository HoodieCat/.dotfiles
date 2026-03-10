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

if pcall(require, 'mini.sessions') then
  aucmd({ 'VimLeavePre' }, {
    callback = function()
      local session = require('mini.sessions')
    end,
  })
end
