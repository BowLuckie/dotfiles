return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true,
      undercurl = false,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      inverse = false, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
    config = function(_, opts)
      -- VERY IMPORTANT: Setup runs BEFORE applying the colorscheme
      require("gruvbox").setup(opts)
      vim.cmd.colorscheme("gruvbox")

      local palette = require("gruvbox").palette

      -- blink.cmp colors
      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = palette.dark1, fg = palette.light1 })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = palette.dark4 })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = palette.dark3 })
      vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = palette.dark1, fg = palette.light1 })
      vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = palette.bright_red })
      vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = palette.bright_green })
      vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = palette.bright_green })
      vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = palette.bright_blue })
      vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = palette.bright_red })
      vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = palette.bright_yellow })
      vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = palette.bright_aqua })
      vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = palette.bright_blue })
      vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = palette.bright_blue })
      vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = palette.light1 })
      vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = palette.light1 })
      vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = palette.bright_orange, bold = true })
      vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = palette.dark4 })
      vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = palette.dark4 })

      vim.api.nvim_set_hl(0, "SignColumn", { bg = palette.dark0 })

      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = palette.bright_red, bg = palette.dark0 })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = palette.bright_yellow, bg = palette.dark0 })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = palette.bright_blue, bg = palette.dark0 })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = palette.bright_aqua, bg = palette.dark0 })

      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = palette.bright_red })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = palette.bright_yellow })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = palette.bright_blue })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = palette.bright_aqua })
      vim.api.nvim_set_hl(0, "SpellBad", { underline = true, sp = palette.bright_red })
      vim.api.nvim_set_hl(0, "SpellCap", { underline = true, sp = palette.bright_blue })

      vim.api.nvim_set_hl(0, "IncSearch", { bg = palette.neutral_orange, fg = palette.dark0 })
      -- selection-background = #d65d0e
      -- selection-foreground = #282828
    end,
  },
}
