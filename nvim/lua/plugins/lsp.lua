local M ={
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason-lspconfig.nvim',
    'saghen/blink.cmp',
    'mason-org/mason.nvim',
    'j-hui/fidget.nvim',
    },
  config = function(_, opts)
	   vim.api.nvim_create_autocmd('LspAttach', {
	     group = vim.api.nvim_create_augroup('Lsp-Attach',{ clear = true}),
         callback = function(arg)
          local map = function(l, r, desc, mode)
              mode = mode or "n"
              vim.keymap.set(mode, l, r, {buffer = arg.buf, desc = 'Lsp'..desc })
          end
          --Lsp keymaps
          map('grn',vim.lsp.buf.rename, '[R]e[n]ame')
          map('gca',vim.lsp.buf.code_action, '[g]oto Code [A]ction')
          map('gr',require('snacks').picker.lsp_definitions , '[G]oto [d]efinition')
          map('gD',require('snacks').picker.lsp_declarations , '[G]oto [D]eclaration')
          map('gr',require('snacks').picker.lsp_references, '[G]oto [r]eferences')
          map('gi',require('snacks').picker.lsp_implementations, '[G]oto [i]mplementation')
          map('gt',require('snacks').picker.lsp_type_definitions , '[G]oto [T]ype Definition')
          map('<leader>ss',function() require('snacks').picker.lsp_workspace_symbols() end, '[S]earch [s]ymbols')
          map('<leader>sS',function() require('snacks').picker.lsp_symbols() end, '[S]earch [s]ymbols [R]oot')
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end
          local client = vim.lsp.get_client_by_id(arg.data.client_id)
            if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, arg.buf) then
              local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false})
              vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'},{
              buffer = arg.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'},{
              buffer = arg.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references
              })

              vim.api.nvim_create_autocmd('LspDetach',{
              group = vim.api.nvim_create_augroup('Lsp-Detach',{ clear = true}),
                callback = function(arg2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds{ group = 'lsp-highlight', buffer = arg2.buf}
                end,
              })
            end
            if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint,arg.buf) then
            map('<leader>ih',function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufner = arg.buf})
              end, '[I]nlay [H]ints')
            end
            if client and client_supports_method(client, vim.lsp.protocol.textDocument_switchHeaderSource, arg.buf) then
              map('<M-o>', '<cmd>ClangdSwitchSourceHeader<CR>', 'Swithc Source/Header')
            end
         end
	   })
	   local capabilities = require('blink.cmp').get_lsp_capabilities()
     local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
	   local servers ={
      clangd = {},
      lua_ls = {
        settings = {
          Lua = {
            completion ={
              callSnippet = 'Replace',
            },
          },
        },
      },
     }
     for server_name, server_config in pairs(servers) do
      server_config.capabilities = vim.tbl_deep_extend('force', lsp_capabilities, capabilities ,server_config.capabilities or {})
      -- require('lspconfig')[server_name].setup(server_config)
      vim.lsp.enable(server_name)
     end
     require("mason").setup({
      registry = {
        "https://gitee.com/mason-org/mason-registry.git"
      }
      })
	   require('mason-lspconfig').setup({
     })
     require("blink.cmp").setup()
  end,
}
return M
