return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },

  opts = function()
    return {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
          },
        },
      },

      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },

      codelens = {
        enabled = false,
      },

      folds = {
        enabled = false,
      },

      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      servers = {
        ["*"] = {
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },

          keys = {
            { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
            {
              "gr",
              function()
                require("snacks").picker.lsp_references()
              end,
              desc = "References",
              nowait = true,
            },
            { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
            { "gy", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
            { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
            { "K", vim.lsp.buf.hover, desc = "Hover" },
            { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
            { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },

            {
              "<leader>ca",
              vim.lsp.buf.code_action,
              desc = "Code Action",
              mode = { "n", "x" },
            },
            {
              "<leader>cc",
              vim.lsp.codelens.run,
              desc = "Run Codelens",
              mode = { "n", "x" },
            },
            {
              "<leader>cC",
              vim.lsp.codelens.refresh,
              desc = "Refresh Codelens",
            },
            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },

            {
              "<leader>cl",
              function()
                require("snacks").picker.lsp_config()
              end,
              desc = "LSP Config",
            },
            {
              "]]",
              function()
                require("snacks").words.jump(1, true)
              end,
              desc = "Next Reference",
            },
            {
              "[[",
              function()
                require("snacks").words.jump(-1, true)
              end,
              desc = "Prev Reference",
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = { enable = true },
              completion = { callSnippet = "Replace" },
              doc = { privateName = { "^_" } },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },

        arduino_language_server = {
          cmd = {
            "arduino-language-server",
            "-cli-config",
            vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
            "-cli",
            "arduino-cli",
            "-clangd",
            vim.fn.stdpath("data") .. "/mason/bin/clangd",
            "-fqbn",
            "teensy:avr:teensy40",
          },
          filetypes = { "arduino" },
          mason = false,
        },

        ocamllsp = {
          settings = {
            codelens = { enable = true },
            inlayHints = { typeAnnotations = true },
            diagnostics = { enable = true },
          },
          mason = false,
        },

        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
        },
        yamlls = {
          filetypes = { "yaml" },
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/clang-format.json"] = "/.clang-format",
              },
            },
          },
        },
      },

      setup = {},
    }
  end,

  config = function(_, opts)
    local capability_for_key = {
      ["gd"] = "textDocument/definition",
      ["gr"] = "textDocument/references",
      ["gI"] = "textDocument/implementation",
      ["gy"] = "textDocument/typeDefinition",
      ["gD"] = "textDocument/declaration",
      ["K"] = "textDocument/hover",
      ["gK"] = "textDocument/signatureHelp",
      ["<c-k>"] = "textDocument/signatureHelp",
      ["<leader>ca"] = "textDocument/codeAction",
      ["<leader>cc"] = "textDocument/codeLens",
      ["<leader>cC"] = "textDocument/codeLens",
      ["<leader>cr"] = "textDocument/rename",
    }

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    if opts.servers["*"] then
      vim.lsp.config("*", opts.servers["*"])
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        local buf = args.buf
        local star = opts.servers["*"]
        local keys = star and star.keys or {}

        for _, key in ipairs(keys) do
          local method = capability_for_key[key[1]]
          if not method or client:supports_method(method) then
            vim.keymap.set(key.mode or "n", key[1], key[2], {
              buffer = buf,
              desc = key.desc,
              nowait = key.nowait,
            })
          end
        end
      end,
    })

    if opts.inlay_hints.enabled then
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if
            vim.api.nvim_buf_is_valid(buf)
            and vim.bo[buf].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buf].filetype)
            and client
            and client:supports_method("textDocument/inlayHint")
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buf })
          end
        end,
      })
    end

    local have_mason = pcall(require, "mason-lspconfig")
    local mason_all = have_mason
        and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
      or {}

    local mason_exclude = {}

    local function configure(server)
      if server == "*" then
        return false
      end

      local sopts = opts.servers[server]
      sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

      if sopts.enabled == false then
        mason_exclude[#mason_exclude + 1] = server
        return
      end

      local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)

      local setup = opts.setup[server] or opts.setup["*"]
      if setup and setup(server, sopts) then
        mason_exclude[#mason_exclude + 1] = server
      else
        vim.lsp.config(server, sopts)
        if not use_mason then
          vim.lsp.enable(server)
        end
      end

      return use_mason
    end

    local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))

    if have_mason then
      require("mason-lspconfig").setup({
        ensure_installed = install,
        automatic_enable = {
          exclude = vim.list_extend(mason_exclude, { "rust_analyzer" }),
        },
      })
    end
  end,
}
