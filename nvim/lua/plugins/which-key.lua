local M =
{"folke/which-key.nvim",
    event = 'VimEnter',
    config = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "[C]ode"},
        {"<leader>d", group = "[D]iagnostic"},
        {"<leader>s", group = "[S]earch"},
        {"<leader>h", group = "Git [H]unk"},
        {"<leader>t", group = "[T]oggle"},
        {"<leader>r", group = "[R]ename"},
        -- {"<leader>b", group = "[B]uffer"},
      })
    end,
}
return M
