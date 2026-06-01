return {
  "mfussenegger/nvim-dap",
  ft = "rust",
  config = function()
  local dap = require("dap")
  local dapui = require("dapui")
  dap.listeners.after.event_terminated["restore_terminal"] = function()
    vim.cmd("mode")
  end
  dap.listeners.after.event_exited["restore_terminal"] = function()
    vim.cmd("mode")
  end
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb.cmd",
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.rust = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          local path = vim.fn.expand("%:p:h")
          local root = path
          while true do
            if vim.fn.filereadable(root .. "\\Cargo.toml") == 1 then
              break
            end
            local parent = vim.fn.fnamemodify(root, ":h")
            if parent == root then
              root = path
              break
            end
            root = parent
          end
          vim.fn.system("cargo build 2>&1")
          local binary = vim.fn.fnamemodify(root, ":t")
          local cargo = io.open(root .. "\\Cargo.toml", "r")
          if cargo then
            for line in cargo:lines() do
              local name = line:match('^name%s*=%s*"(.+)"')
              if name then binary = name break end
            end
            cargo:close()
          end
          return root .. "\\target\\debug\\" .. binary .. ".exe"
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        sourceLanguages = { "rust" },
        initCommands = {
          "settings set target.inline-breakpoint-strategy always",
        },
      },
    }
  end,
}
