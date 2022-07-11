local cmp = require('cmp')
local luasnip = require('luasnip')
local function has_words_before()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]:sub(col, col):match('%s') == nil
end
cmp.setup {
  mapping = {
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<Tab>'] = cmp.mapping.confirm {
      select = true
    }
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' }
  }
}

Capabilities = vim.lsp.protocol.make_client_capabilities()
Capabilities = require('cmp_nvim_lsp').update_capabilities(Capabilities)
Capabilities.textDocument.completion.completionItem.snippetSupport = true
LspConfig = require('lspconfig')
local servers = {
  'cssls',
  'gopls',
  'tsserver'
}
for _, lsp in ipairs(servers) do
  LspConfig[lsp].setup {
    capabilities = Capabilities
  }
end

require('nvim-treesitter.configs').setup {
  auto_install = true,
  highlight = {
    enable = true
  }
}

vim.g.vscode_transparent = 1
vim.cmd('colorscheme vscode')
vim.keymap.set('n', '<C-p>', ':GFiles<CR>')
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.wrap = false
