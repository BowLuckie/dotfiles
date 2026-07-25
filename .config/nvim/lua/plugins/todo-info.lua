return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Prev Todo Comment",
      },
      {
        "<leader>st",
        function()
          Snacks.picker.grep({
            search = "TODO|FIXME|HACK|WARN|PERF|NOTE",
            regex = true,
          })
        end,
        desc = "Todo",
      },
    },
  },
}
