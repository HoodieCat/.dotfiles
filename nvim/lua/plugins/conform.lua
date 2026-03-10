return {
  'stevearc/conform.nvim',
  cmd = 'ConformInfo',
  lazy = true,
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        rust = { 'rustfmt', lsp_format = 'fallback' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd' },
        cmake = { 'cmakelang' },
        makefile = { 'mbake' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
      },
    })
  end,
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format()
      end,
    },
    mode = { 'n', 'x' },
    desc = 'Format!',
  },
}
