local opt = setmetatable({},{ __newindex = function(self,k,v) vim.o[k] = v end})
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.clipboard = 'unnamedplus'
opt.wrap = true
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 1000
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.inccommand = 'nosplit'
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true
opt.numberwidth = 4

-- set '-' as part of word on searching
vim.opt.iskeyword:append "-" 
vim.g.mapleader = ' '
