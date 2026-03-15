return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  lazy = false,
  build = ':TSUpdate',
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    fold = { enable = true },
  },
}
