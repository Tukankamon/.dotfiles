return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
      require('nvim-treesitter').install({
        'lua',
        'rust',
        'c',
        'zig',
        'haskell',
        'nix',
        'go',
        'markdown',
        'markdown_inline'
      }):wait(100000);

    -- treesitter parsers (dont really know how this works)
    vim.api.nvim_create_autocmd('FileType', {
        callback = function()
            pcall(vim.treesitter.start)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
  end,
}
