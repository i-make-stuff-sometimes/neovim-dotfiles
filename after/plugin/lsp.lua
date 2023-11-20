local lsp = require("lsp-zero")

require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.eslint.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.docker_compose_language_service.setup{}
require'lspconfig'.csharp_ls.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.htmx.setup{}
require'lspconfig'.lua_ls.setup{}


lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

cmp.setup({
  mapping = cmp.mapping.preset.insert({

    ["<Tab>"] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
	if not entry then
	  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	else
	  cmp.confirm()
	end
      else
        fallback()
      end
    end, {"i","s","c",}),
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

lsp.setup()
