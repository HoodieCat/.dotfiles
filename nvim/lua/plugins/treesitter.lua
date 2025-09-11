local M= {}
-- for windows os
local powershell = vim.fn.has('win32') and "powershell" or ""
M={
  "nvim-treesitter/nvim-treesitter",
  version = false, --using the main branch instead of the default master branch :same as branch = main
  build = ":TSUpdate",
  lazy = vim.fn.argc(-1) == 0, --loaded lazy treesiter whenever open a file
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      powershell,
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>ti",-- [t]reesitter [i]ncremental selection
        node_incremental = "<leader>ti",
        node_decremental = "<leader>td",-- [t]reesitter [d]ecremental selection
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
return M
