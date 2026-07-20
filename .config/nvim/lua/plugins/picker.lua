return {
  "folke/snacks.nvim",
  opts = {},
  keys = {
      -- stylua: ignore start
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader><leader>", function() Snacks.picker.files({ hidden = true, ignored = false }) end, desc = "Find Files (all)" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Grep Word/Selection" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Tags" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },

      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
      { "<leader>bi", function() Snacks.bufdelete.invisible() end, desc = "Delete Invisible Buffers" },

      { "<leader>gG", function() Snacks.lazygit() end, desc = "Lazygit (cwd)" },

      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Current File History" },
      { "<leader>gx", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gL", function() Snacks.picker.git_log() end, desc = "Git Log (cwd)" },
      { "<leader>gb", function() Snacks.picker.git_log_line() end, desc = "Git Blame Line" },
      { "<leader>gB", function() Snacks.gitbrowse() end, mode = { "n", "x" }, desc = "Git Browse (open)" },
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub PRs (open)" },
      { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub PRs (all)" },

      { "<leader>fT", function() Snacks.terminal() end, desc = "Terminal (cwd)" },
      { "<C-/>", function() Snacks.terminal.focus() end, mode = { "n", "t" }, desc = "Terminal Focus" },
      { "<C-_>", function() Snacks.terminal.focus() end, mode = { "n", "t" }, desc = "which_key_ignore" },

      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "Calls Incoming" },
      { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "Calls Outgoing" },

      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

    -- stylua: ignore end
    {
      "<leader>gY",
      function()
        Snacks.gitbrowse({
          open = function(url)
            vim.fn.setreg("+", url)
          end,
          notify = false,
        })
      end,
      mode = { "n", "x" },
      desc = "Git Browse (copy)",
    },

    {
      "<leader>fc",
      function()
        Snacks.picker.files({
          cwd = vim.fs.normalize(vim.fn.expand("~/.dotfiles/.config/nvim")),
        })
      end,
      desc = "Find Config File",
    },

    {
      "<leader>gg",
      function()
        Snacks.lazygit({
          cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
        })
      end,
      desc = "Lazygit (Root Dir)",
    },

    {
      "<leader>gl",
      function()
        Snacks.picker.git_log({
          cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
        })
      end,
      desc = "Git Log",
    },

    {
      "<leader>ft",
      function()
        Snacks.terminal(nil, {
          cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
        })
      end,
      desc = "Terminal (Root Dir)",
    },
  },
}
