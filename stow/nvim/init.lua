vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.vim_markdown_folding_disable = 1

vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "$", "g$", { silent = true })
vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Allows moving blocks in v mode
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Deletes into the void register so you can paste over without losing the buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- System clipboard instead of "+y
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Command to replace the word you are on in the whole file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0 -- Uses tabstop value
vim.opt.linebreak = true -- Logical wrapping

vim.opt.wrap = true
vim.opt.incsearch = true

-- diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- PLUGINS

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
        require('nvim-treesitter').install({ 'lua', 'rust', 'c', 'zig', 'haskell', 'nix', 'markdown', 'markdown_inline' }):wait(300000)
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
	{ 'lewis6991/gitsigns.nvim' }
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

local lspconfig = require("lspconfig")
vim.lsp.config("rust_analyzer", {})
vim.lsp.config("clangd", {})
vim.lsp.config("hls", {})
vim.lsp.config("nil", {})
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
  "nil",
})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

require("nord").set()
vim.cmd[[colorscheme nord]]
