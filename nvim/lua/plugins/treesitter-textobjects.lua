local M ={}
M =
{
  --Treesitter enhance for textobject movie/swap/
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    dependencies = 
    {  "nvim-treesitter/nvim-treesitter" },
    config = function()
      local treesitter = require("nvim-treesitter.configs").setup({
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
        select = {
          enable = true,
        },
      },
      })
    end
}
return M
