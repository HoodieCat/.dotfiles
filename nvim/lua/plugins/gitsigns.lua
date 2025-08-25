local M = {}
M = {
    "lewis6991/gitsigns.nvim",
    cond = function()
	--when in a git repo vim.v.shell_error =0
	return vim.fn.system('git rev-parser --is-inside-work-tree')
    end,
    config = function()
	require('gitsigns').setup()
    end,
}
return M
