return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics" },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          { "diff" },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%I:%M"):gsub("^0", "")
          end,
        },
      },
    },
  },
}

--   {
--     "nvim-lualine/lualine.nvim",
--     opts = {
--       sections = {
--         lualine_z = {
--           function()
--             return " " .. os.date("%I:%M"):gsub("^0", "")
--           end,
--         },
--       },
--     },
--   },
-- }
