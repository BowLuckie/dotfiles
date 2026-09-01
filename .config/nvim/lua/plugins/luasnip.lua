return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()

    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.add_snippets("rust", {
      s("allow", {
        t({ "#[allow(" }),
        i(1),
        t({ ")]" }),
      }),
      s("allow_inner", {
        t({ "#![allow(" }),
        i(1),
        t({ ")]" }),
      }),
      s("main", {
        t({ "fn main() {", "\t" }),
        i(1),
        t({ "", "}" }),
      }),
    })
  end,
}
