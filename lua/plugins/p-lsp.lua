local on_attch_=function(client,bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr,...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr,...)
	end

	buf_set_option("omnifunc","v:lua.vim.lsp.omnifunc")
	local opts = {noremap = true, silent = true}

	buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>",opts)

end


local on_attach=function(_,bufnr)
    local opts_buffer = { noremap = true, silent = true, buffer = bufnr }
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings: LSP
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts_buffer)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts_buffer)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts_buffer)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts_buffer)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts_buffer)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts_buffer)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts_buffer)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts_buffer)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts_buffer)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts_buffer)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts_buffer)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts_buffer)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts_buffer)
    vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts_buffer)

end


local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end



return{
  { 
	   "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }

  },

  {
	"williamboman/mason-lspconfig.nvim",
	dependencies={"mason.nvim"},
	opts = {
        ensure_installed = { "lua_ls", "rust_analyzer" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },

  },
  {
	"neovim/nvim-lspconfig",

  },
  {
      "hrsh7th/vim-vsnip",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { 
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip", -- For luasnip users.
    },
    config=function()
	    local cmp = require('cmp')
	    local luasnip = require('luasnip')
	    cmp.setup({
		    snippet = {
		      -- REQUIRED - you must specify a snippet engine
		      expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                -- luasnip.lsp_expand(args.body) -- For `luasnip` users.
		      end,
		    },
		    window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
		      formatting = {
			    fields = {'menu', 'abbr', 'kind'},
			    format = function(entry, item)
			      local menu_icon = {
				nvim_lsp = 'λ',
				luasnip = '⋗',
				buffer = 'Ω',
				path = '🖫',
			      }

			      item.menu = menu_icon[entry.source.name]
			      return item
			    end,
			  },
            
		    mapping = cmp.mapping.preset.insert({
			    ["<Tab>"] = cmp.mapping(function(fallback)
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
			    ["<S-Tab>"] = cmp.mapping(function(fallback)
			      if cmp.visible() then
				cmp.select_prev_item()
			      elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			      else
				fallback()
			      end
			    end, { "i", "s" }),
		      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		      ['<C-f>'] = cmp.mapping.scroll_docs(4),
		      ['<C-Space>'] = cmp.mapping.complete(),
		      ['<C-e>'] = cmp.mapping.abort(),
		      ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		    }),
		    sources = cmp.config.sources({
		      { name = 'nvim_lsp' },
		      { name = 'vsnip' }, -- For vsnip users.
		      { name = 'luasnip' }, -- For luasnip users.
              { name = 'path' }, -- For path completions.
		      -- { name = 'ultisnips' }, -- For ultisnips users.
		      -- { name = 'snippy' }, -- For snippy users.
		    }, {
		      { name = 'buffer' },
		    })

	    })
    end
    ---@param opts cmp.ConfigSchema
    -- opts = function(_, opts)
    --   table.insert(opts.sources, { name = "emoji" })
    -- end,
  },
}
