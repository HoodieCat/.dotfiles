local M ={
  'saghen/blink.cmp',
  version = '1.*',
  dependencies  = {
    -- snippet Engine
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = (function()
      if vim.fn.has "win32" ==1 or vim.fn.executable 'make' ==0 then
	return
      end
      return 'make install_jsregexp'
    end)(),
  }
}
return M
