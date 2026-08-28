return {
  "neovim/nvim-lspconfig",

  config = function()
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
  end
}
