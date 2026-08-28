-- luasnip.lua

-- ChatGpt, should revert to normal "key" behaviour if there are no snippets
local function fallback_key(key)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(key, true, false, true),
    "i",
    false
  )
end

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
    local fmt = require("luasnip.extras.fmt").fmt

    -- Expands the snippets on Tab in insert
    vim.keymap.set("i", "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        fallback_key("<Tab>")
      end
    end, {silent = true})

    vim.keymap.set("i", "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback_key("<S-Tab>")
      end
    end, {silent = true})

    -- === SNIPPETS ===
    -- Could move them into separate files if they get too big
    ls.add_snippets("lua", {
      s("hello", {
        t('print("hello world")'),
        i(1),
        t('hello again'),
        i(2),
      })
    })

    ls.add_snippets("markdown", {
      s("code", fmt(
        [[
          ```{}
          {}
          ```
        ]],
        { i(1), i(2) }
      )),

      s("mk", fmt(
        [[
          ${}$
        ]],
        { i(1) }
      )),

      s("dm", fmt(
        [[
          $$
          {}
          $$
        ]],
        { i(1) }
      )),
  })
  end
}
