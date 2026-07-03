return {
  "okuuva/auto-save.nvim",
  opts = {
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = {},
    },
  },
}
