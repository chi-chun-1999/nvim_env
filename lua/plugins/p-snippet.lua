return{
  {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
    config = function()
        local types = require("luasnip.util.types")
        require("luasnip.loaders.from_snipmate").lazy_load({paths = {"~/.local/share/nvim/plugged/vim-snippets/snippets"}}) -- Load snippets from LuaSnip style snippets
        require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/my_snippets"}}) -- Load snippets from VSCode style snippets
        require('luasnip').setup {
            history = true,
            delete_check_events = 'TextChanged',
            -- Display a cursor-like placeholder in unvisited nodes
            -- of the snippet.
            ext_opts = {
                [types.insertNode] = {
                    unvisited = {
                        virt_text = { { '|', 'Conceal' } },
                        virt_text_pos = 'inline',
                    },
                },
            },
        }
    end,
  },
  {
      'honza/vim-snippets',
        -- Load snippets from vim-snippets
  }

}
