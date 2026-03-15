local M = {}
M = {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    explorer = {
      replace_netrw = true,
    },
    indent = {},
    -- dashboard = {},
    input = {},
    win = {
      keys = {
        ['<C-M-h>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
      },
    },
  },
  config = function(_, opts)
    -- set snacks as default explorer,already disable netrw
    require('snacks').setup(opts)
  end,
  keys = {
    -- local root =
    {
      '<leader>e',
      function()
        Snacks.explorer.open()
      end,
      desc = 'Explorer',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[N]otifacations',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[G]rep',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch Recent files',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[s]earch [h]elp',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.smart()
      end,
      desc = '[S]earch [S]mart',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Bufers',
    },
    {
      '<leader>sf',
      function()
        local opts = {}
        Snacks.picker.files(opts)
      end,
      desc = '[S]earch [f]ile cwd',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = '[S]earch [C]onfig',
    },
    --using .git as root directory sign
    {
      '<leader>E',
      function()
        local root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
        if root == '' then
          root = vim.fn.getcwd()
        end
        Snacks.picker.explorer({ cwd = root, ignored = false })
      end,
      desc = '',
    },
    --search files under root dir at the rule of .gitignore without hidden files
    {
      '<leader>sF',
      function()
        local root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
        if root == '' then
          root = vim.fn.getcwd()
        end
        Snacks.picker.files({ cwd = root })
      end,
      desc = '[S]earch [F]iles Root dir',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = '[G]it log',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = '[S]earch Current [B]ufer line',
    },
    {
      '<leader>so',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[S]earch Grep [O]pen buffers',
    },
    --command
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = '[S]earch [c]ommand history',
    },
    --Resume
    {
      '<leader>r',
      function()
        Snacks.picker.resume()
      end,
      desc = '[S]earch [R]esume',
    },
    --keymap
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[K]eymap',
    },
    --Lsp
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
  },
}
return M
