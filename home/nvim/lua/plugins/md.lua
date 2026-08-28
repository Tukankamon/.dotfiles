return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { -- if you use the mini.nvim suite
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim'
  },
  --[[
  dependencies = { -- if you use standalone mini plugins
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.icons'
  },
  --]]

  ---@module 'render-markdown'
  opts = {}
}
