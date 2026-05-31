return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    execution_message = {
      enabled = false, -- Disables the annoying "AutoSaved at HH:MM" message
    },
  },
}
