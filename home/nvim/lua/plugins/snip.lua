-- luasnip.lua
-- SOURCES FOR STUFF:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

return {
  "L3MON4D3/LuaSnip",

  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)

  -- install jsregexp (optional!). (idk what it is for)
  --build = "make install_jsregexp"

  config = function()
    local ls = require("luasnip")
    ls.setup({ enable_autosnippets = true })
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    -- fmta bc latex uses {} a lot and escaping is a pain, this uses <>
    local fmt = require("luasnip.extras.fmt").fmta

    -- TODO make it shorter so it fits on a half screen
    vim.cmd[[
    " Use Tab to expand and jump through snippets
    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
    smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

    " Use Shift-Tab to jump backwards through snippets
    imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
    ]]
    --[[ These break the config but could be useful
      " Cycle forward through choice nodes with Control Tab
      imap <silent><expr> <C-Tab> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
      smap <silent><expr> <C-Tab> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
    --]]

    -- === SNIPPETS ===
    -- Could move them into separate files if they get too big
    ls.add_snippets("lua", {
      s("hello", {
        t('print("hello world")'),
        i(1),
        t('alright again'),
        i(2),
      })
    })

    local latex = require("plugins.snippets.latex")
    ls.add_snippets("markdown", latex)

    ls.add_snippets("markdown", latex)
    ls.add_snippets("markdown", {
      s({trig="code", snippetType="autosnippet"},
      fmt([[
        ```<>
        <>
        ```
        <>
      ]],
      { i(1), i(2), i(3) }
      )),

  })
  end
}
