vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.vim_markdown_folding_disable = 1

vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "$", "g$", { silent = true })
vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })
vim.keymap.set("i", "<C-h>", "<C-w>", { silent = true }) -- Wont work with tmux if not

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Allows moving blocks in v mode
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Deletes into the void register so you can paste over without losing the buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- System clipboard instead of "+y
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Some builders dont really work
vim.keymap.set("n", "<leader>m", ":make<cr>")

-- Command to replace the word you are on in the whole file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Pop a terminal on the bottom of the screen
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end)

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0 -- Uses tabstop value
vim.opt.linebreak = true -- Logical wrapping
vim.opt.expandtab = true

vim.opt.wrap = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Better colouring for csv files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.cmd([[
      syntax clear
      " Column matches (up to 10)
      syntax match csvCol1  /^[^,]*/
      syntax match csvCol2  /,\zs[^,]*/
      syntax match csvCol3  /,\([^,]*,\)\zs[^,]*/
      syntax match csvCol4  /,\([^,]*,\)\{2}\zs[^,]*/
      syntax match csvCol5  /,\([^,]*,\)\{3}\zs[^,]*/
      syntax match csvCol6  /,\([^,]*,\)\{4}\zs[^,]*/
      syntax match csvCol7  /,\([^,]*,\)\{5}\zs[^,]*/
      syntax match csvCol8  /,\([^,]*,\)\{6}\zs[^,]*/
      syntax match csvCol9  /,\([^,]*,\)\{7}\zs[^,]*/
      syntax match csvCol10 /,\([^,]*,\)\{8}\zs[^,]*/

      " Highlight groups (intentionally varied)
      highlight csvCol1  guifg=#FF5555 ctermfg=203
      highlight csvCol2  guifg=#50FA7B ctermfg=84
      highlight csvCol3  guifg=#8BE9FD ctermfg=117
      highlight csvCol4  guifg=#BD93F9 ctermfg=141
      highlight csvCol5  guifg=#FFB86C ctermfg=215
      highlight csvCol6  guifg=#F1FA8C ctermfg=228
      highlight csvCol7  guifg=#FF79C6 ctermfg=212
      highlight csvCol8  guifg=#7AFCD6 ctermfg=122
      highlight csvCol9  guifg=#C0C0FF ctermfg=147
      highlight csvCol10 guifg=#FFAFAF ctermfg=217
      ]])
  end,
})

require("plugins")
