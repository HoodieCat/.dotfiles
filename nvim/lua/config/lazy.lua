local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    {
      'folke/tokyonight.nvim',
      priority = 1000,
      lazy = false,
      config = function()
        vim.cmd.colorscheme('tokyonight')
      end,
    },
    {
      'iamcco/markdown-preview.nvim',
      -- cmd = { 'MarkdownPreviewToggle' },
      build = { 'cd app && yarn install' },
      init = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      ft = { 'markdown' },
      keys = { { '<leader>pp', '<cmd>MarkdownPreviewToggle<CR>' } },
    },
    { import = 'plugins' },
  },
  lazy = true,
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
