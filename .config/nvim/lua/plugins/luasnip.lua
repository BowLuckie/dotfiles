return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = function(_, _)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").load({
      paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
    })
  end,
}
