-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{"shaunsingh/nord.nvim", name = "nord", priority = 1000},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install({ 'lua', 'rust', 'c', 'zig', 'haskell', 'nix', 'go', 'markdown', 'markdown_inline' }):wait(100000)
    end,
	},
	{
		'nvim-telescope/telescope.nvim', version = '*',
		dependencies = {'nvim-lua/plenary.nvim'}
	},
	{ "neovim/nvim-lspconfig" },
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },            -- if you use the mini.nvim suite
		--dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		---@module 'render-markdown'
		opts = {}
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true }
	},
	--{ 'lewis6991/gitsigns.nvim' }
}

local opts = {}

require("lazy").setup(plugins, opts)

-- treesitter parsers
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

vim.lsp.config("rust_analyzer", {})
vim.lsp.config("clangd", {})
vim.lsp.config("hls", {})
vim.lsp.config("nil_ls", {
	settings = {
		["nil"] = {
			nix = {
				flake = { autoArchive = true, }
			}
		}
	}
})
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "clangd",
  "hls",
  "nil_ls",
})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

require("lualine").setup()

require("nord").set()
vim.cmd[[colorscheme nord]]
