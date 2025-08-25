local M = {}
M = {
    "lewis6991/gitsigns.nvim",
    cond = function()
	--when in a git repo vim.v.shell_error =0
	return vim.fn.system('git rev-parse --is-inside-work-tree')
	   end,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          local function map(mode, l, r, opts)
            local options = opts or {}
            vim.keymap.set(mode,l ,r ,opts)
	    end
            -- enter diff mode
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.fn.cmd("normal!  ]c")
                else
                    gitsigns.nav_hunk("next")
                end 
            end, {desc = "Jump to next [G]it [C]hange"})

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.fn.cmd("normal!  [c")
                else
                    gitsigns.nav_hunk("prev")
                end 
            end, {desc = "Jump to previous [G]it [C]hange"})

            --visual mode hunk 
            map("v","<leader>hs",function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v")})
            end, {desc ="Git [H]unk [S]tage Visual Selection"})
            map('v', '<leader>hr', function()
                gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v")}
            end, { desc = 'Git [H]unk [R]eset' })
            --normal mode hunk
            map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk [T]oggle' })
            map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
            map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
            map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
            map('n', '<leader>hp', gitsigns.preview_hunk_inline, { desc = 'git [p]review hunk' })
            map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
            map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        end
    },
    config = function(_, opts)
        require('gitsigns').setup(opts)
    end,
}
return M
