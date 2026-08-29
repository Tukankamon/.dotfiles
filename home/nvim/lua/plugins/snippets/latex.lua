-- latex.lua
-- Separate file to reuse it both in markdown and latex, there is also a lot of them

-- https://ejmastnak.com/tutorials/vim-latex/luasnip/
-- https://castel.dev/post/lecture-notes-1/

local ls = require("luasnip")
ls.setup({ enable_autosnippets = true })
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- fmta bc latex uses {} a lot and escaping is a pain, this uses <>
local fmt = require("luasnip.extras.fmt").fmta
local f = ls.function_node
local d = ls.dynamic_node

return {
  s({trig="ZZ", snippetType="autosnippet"}, t('\\mathbb{Z}')),
  s({trig="RR", snippetType="autosnippet"}, t('\\mathbb{R}')),
  s({trig="QQ", snippetType="autosnippet"}, t('\\mathbb{Q}')),

  s({trig="qed", snippetType="autosnippet"}, t('\\blacksquare')),

  s({trig="lim", snippetType="autosnippet"}, t('\\lim_{n \\to \\infty}')),

  -- There is a '{}' at the end to be able to go back if needed to the other inputs
  -- Could look into making a custom math "mode" so that these only trigger there
  -- (explained in one of the links above with vimtex
  s({trig="mk", snippetType="autosnippet"},
  fmt([[
    $<>$<>
  ]],
  { i(1), i(2)}
  )),

  s({trig="dm", snippetType="autosnippet"},
  fmt([[
    $$
    <>
    $$
    <>
  ]],
  { i(1), i(2)}
  )),

  s({trig="//", snippetType="autosnippet"},
  fmt([[
    \frac{<>}{<>}<>
  ]],
  { i(1), i(2), i(3)}
  )),

  s({trig="sum", snippetType="autosnippet"},
  fmt([[
    \sum_{<>}^{<>}<>
  ]],
  { i(1), i(2), i(3)}
  )),

  s({trig="prod", snippetType="autosnippet"},
  fmt([[
    \prod{<>}^{<>}<>
  ]],
  { i(1), i(2), i(3)}
  )),

  -- TODO make it so that S-Tab can get inside the first <>
  s({trig="([%d])//", snippetType="autosnippet", regTrig=true},
  fmt([[
    \frac{<>}{<>}<>
  ]],
  { f( function(_, snip) return snip.captures[1] end ), i(1), i(2)}
  )),

  s({trig="([%a])bar", snippetType="autosnippet", regTrig=true},
  fmt([[
    \overline{<>}<>
  ]],
  { f( function(_, snip) return snip.captures[1] end ), i(1)}
  )),

  s({trig="([%a])hat", snippetType="autosnippet", regTrig=true},
  fmt([[
    \hat{<>}<>
  ]],
  { f( function(_, snip) return snip.captures[1] end ), i(1)}
  )),

  -- The other one is higher priority: xbar > bar
  s({trig="bar", snippetType="autosnippet", regTrig=true, priority=998},
  fmt([[
    \overline{<>}<>
  ]],
  { i(1), i(2)}
  )),

  s({trig="hat", snippetType="autosnippet", regTrig=true, priority=998},
  fmt([[
    \hat{<>}<>
  ]],
  { i(1), i(2)}
  )),
}
