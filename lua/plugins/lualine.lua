return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_z = {
          function()
            return " " .. os.date("%I:%M"):gsub("^0", "")
          end,
        },
      },
    },
  },
}
