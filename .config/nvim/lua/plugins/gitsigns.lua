return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
    keys = {
      {
        "]h",
        function()
          require("gitsigns").nav_hunk("next")
        end,
        desc = "Next Hunk",
      },
      {
        "[h",
        function()
          require("gitsigns").nav_hunk("prev")
        end,
        desc = "Prev Hunk",
      },
      {
        "<leader>ghs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "<leader>ghr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>ghp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>ghb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Blame Line",
      },
    },
  },
}
