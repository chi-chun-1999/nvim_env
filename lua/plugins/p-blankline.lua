
return{
    {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = function()
      local hl_name_list = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterBlue',
        'RainbowDelimiterCyan',
        'RainbowDelimiterViolet',
      }
      require('ibl').setup({
        scope = {
          enabled = true,
          show_start = false,
          highlight = hl_name_list
        }
      })
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

    {
      'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
      config = function()
        local colors = {
          Red = '#EF6D6D',
          Orange = '#FFA645',
          Yellow = '#EDEF56',
          Green = '#6AEF6F',
          Cyan = '#78E6EF',
          Blue = '#70A4FF',
          Violet = '#BDB2EF',
        }
        local rainbow_delimiters = require('rainbow-delimiters')

        vim.g.rainbow_delimiters = {
          strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
          },
          query = {
            [''] = 'rainbow-delimiters',
          },
          highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterBlue',
            'RainbowDelimiterCyan',
            'RainbowDelimiterViolet',
          },
        }
      end
    }
}

