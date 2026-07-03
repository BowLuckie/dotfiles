return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
    version = "1.*",
    opts = {
      keymap = { preset = "enter" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}
