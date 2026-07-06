return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },
    version = "1.*",
    opts = {
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        ghost_text = { enabled = true },
        documentation = { auto_show = false },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
      },
      keymap = {
        preset = "enter",
        ["<C-space>"] = { "show_documentation", "hide_documentation" },
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
