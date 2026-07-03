return {
  "folke/snacks.nvim",
  opts = {},
  keys = {
    {
      "<leader>ff",
      function()
        require("snacks").picker.files()
      end,
      desc = "Find Files",
    },

    {
      "<leader><leader>",
      function()
        require("snacks").picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>fr",
      function()
        require("snacks").picker.oldfiles()
      end,
      desc = "Recent Files",
    },
    {
      "<leader>fh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Help Tags",
    },
    {
      "<leader>fc",
      function()
        require("snacks").picker.files({
          cwd = vim.fn.stdpath("config"),
        })
      end,
      desc = "Find Config File",
    },
  },
}
