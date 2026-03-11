return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local pwsh_options = {
      shell = 'pwsh',
      shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
      shellredir = '-RedirectStandardOutput %s - NoNewWindow -Wait',
      shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
      shellquote = '',
      shellxquote = '',
    }
    for options, value in pairs(pwsh_options) do
      vim.o[options] = value
    end
    require('toggleterm').setup({
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    })
    vim.api.nvim_create_autocmd('TermEnter', {
      pattern = 'term://*toggleterm#*',
      group = vim.api.nvim_create_augroup('toggle-term', { clear = true }),
      callback = function()
        vim.keymap.set('t', '<C-\\>', function()
          vim.cmd(vim.v.count1 .. 'ToggleTerm')
        end)
      end,
    })
  end,
  keys = {
    {
      '<C-\\>',
      function()
        vim.cmd(vim.v.count1 .. 'ToggleTerm')
      end,
      mode = { 'i', 'n' },
      desc = 'Toggle Terminal',
    },
  },
}
