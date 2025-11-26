local M ={
  'saghen/blink.cmp',
  version = '1.*',
  dependencies  = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'default'},
    appearance = { nerd_font_variant = 'mono'},
    sources = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}
return M
