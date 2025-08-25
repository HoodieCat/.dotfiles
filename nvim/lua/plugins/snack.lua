local M = {}
M = {
    "folke/snacks.nvim",
    dependency = {},
    opts = {
        explorer = {
        },
    },
    config = function(_, opts)
    -- set snacks as default explorer
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("snacks").setup(opts)
    end,
    keys = {
        { "<leader>e", function() Snacks.explorer.open() end, desc = "Explorer"},
        {"<leader>n", function() Snacks.picker.notifications() end, desc = "[N]otifacations"},
        {"<leader>g", function() Snacks.picker.grep() end, desc = "[G]rep"},
        {"<leader>s.", function() Snacks.picker.recent() end, desc = "[S]earch Recent files"},
        {"<leader>sh", function() Snacks.picker.help() end , desc = "[s]earch [h]elp"},
        { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Bufers" },
        {"<leader>sf", function() Snacks.picker.files() end, desc= "[s]earch [f]ile"},
    },
}
return M
