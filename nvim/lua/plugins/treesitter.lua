local M ={}
M= {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    branch = "master",
    opts = {
        ensure_installed = { 'cpp','bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc'},
        auto_install = true,
        highlight = { enable = true, },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremential = "<bs>",
            },
        },
        textobjects ={
             move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
                    },
        },
    },
    keys= {
        {"<c-space>", desc = "Increment Selection"},
        {"<bs>", desc = "Descrement Selection"},
    },


}
return M
