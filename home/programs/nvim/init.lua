---@diagnostic disable: undefined-global

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.vim_markdown_folding_disable = 1

vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "$", "g$", { silent = true })
vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Allows moving blocks in v mode
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv") -- Allows moving blocks in v mode

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
