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
          {
            update = { "User", pattern = "ClocStatusUpdated" },
            function()
              local status = require("cloc").get_status()
              if status.statusCode == "loading" then
                return "Clocing..."
              end
              if status.statusCode == "error" then
                return "Error"
              end
              return status.data[1].code .. " LOC"
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            local time = os.date("%I:%M") --[[@as string]]
            return " " .. time:gsub("^0", "")
          end,
        },
      },
    },
  },
}
