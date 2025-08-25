local M = {}
M = {
    "folke/snacks.nvim",
    opts = {
        explorer = {
            replace_netrw = true,
        },
        indent ={
        },
    },
    config = function(_, opts)
    -- set snacks as default explorer
        require("snacks").setup(opts)
    end,
    keys = {
        -- local root = 
        {"<leader>e", function() Snacks.explorer.open() end, desc = "Explorer"},
        {"<leader>n", function() Snacks.picker.notifications() end, desc = "[N]otifacations"},
        {"<leader>sg", function() Snacks.picker.grep() end, desc = "[G]rep"},
        {"<leader>s.", function() Snacks.picker.recent() end, desc = "[S]earch Recent files"},
        {"<leader>sh", function() Snacks.picker.help() end , desc = "[s]earch [h]elp"},
        {"<leader>ss", function() snacks.picker.smart() end, desc ="[S]earch [S]mart"},
        { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Bufers" },
        {"<leader>sf", function() Snacks.picker.files() end, desc= "[S]earch [f]ile cwd"},
        {"<leader>sC", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config")}) end, desc = "[S]earch [C]onfig"},
        --using .git as root directory sign
        {"<leader>E", function()
            local root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n',"")
            if root == "" then
                root = vim.fn.getcwd()
            end
            Snacks.picker.explorer({cwd = root}) end , desc =""},
        {"<leader>sF", function()
            local root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n',"")
            if root == "" then
                root = vim.fn.getcwd()
            end
            Snacks.picker.files({cwd = root}) end , desc ="[S]earch [F]iles Root dir"},
        {"<leader>sp", function() Snacks.picker.projects() end, desc = "[P]rojects"},
        {"<leader>gl", function() Snacks.picker.git_log() end, desc = "[G]it log" },
        --Grep
        {"<leader>sb",function() Snacks.picker.lines() end, desc = "[S]earch Current [B]ufer line"},
        {"<leader>so",function() Snacks.picker.grep_buffers() end, desc ="[S]earch Grep [O]pen buffers"},
        {"<leader>sw",function() Snacks.picker.grep_word() end, desc="[S]earch Visual selection Word", mode = {"n", "x"}},
        --command
        {"<leader>sc",function() Snacks.picker.command_history() end, desc = "[S]earch [c]ommand history"},
        --Resume
        {"<leader>r",function() Snacks.picker.resume() end, desc = "[R]esume"},
        --keymap
        {"<leader>sk",function() Snacks.picker.keymaps() end, desc = "[K]eymap"},
        --Lsp
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    },
}
return M
