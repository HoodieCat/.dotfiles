return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    local pwsh_options = {
      shell = 'pwsh',
      shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
      shellredir = '-RedirectStandardOutput %s - NoNewWindow -Wait',
      shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
      shellquote = "",
      shellxquote = "",
    }
    for options,value in pairs(pwsh_options) do
      vim.o[options] = value
    end
  require('toggleterm').setup{
    direction = 'float',
    float_opts = {
      border = 'curved',
    }
  }
  end,
  keys = {
    { '<C-\\>',function()
      local cout = vim.v.count1
      vim.cmd(cout .. "ToggleTerm")
    end,mode = { 'i', 'n', 't'}, desc = "Toggle Terminal"},
  }
}
