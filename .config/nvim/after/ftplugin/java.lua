local jdtls = require("jdtls")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name

local config = {
  cmd = {
    "jdtls",
    "-data",
    workspace_dir,
  },

  root_dir = require("jdtls.setup").find_root({
    ".git",
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
  }),

  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
      },
    },
  },

  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)
