return {
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
        mode = "n",
        desc = "Increment",
      },
      {
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "normal")
        end,
        mode = "n",
        desc = "Decrement",
      },
      {
        "g<C-a>",
        function()
          require("dial.map").manipulate("increment", "gnormal")
        end,
        mode = "n",
        desc = "Increment (g)",
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gnormal")
        end,
        mode = "n",
        desc = "Decrement (g)",
      },
      {
        "<C-a>",
        function()
          require("dial.map").manipulate("increment", "visual")
        end,
        mode = "v",
        desc = "Increment",
      },
      {
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "visual")
        end,
        mode = "v",
        desc = "Decrement",
      },
      {
        "g<C-a>",
        function()
          require("dial.map").manipulate("increment", "gvisual")
        end,
        mode = "v",
        desc = "Increment (g)",
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gvisual")
        end,
        mode = "v",
        desc = "Decrement (g)",
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "==", "!=" }, word = false, cyclic = true }),
        },
      })
    end,
  },
}
