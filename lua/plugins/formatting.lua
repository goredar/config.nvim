return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        -- markdown = { "write_good", "markdownlint-cli2" },
        -- proto = { "buf" },
        -- json = { "jq" },
        -- jsonc = { "prettier" },
        -- json = { "prettier" },
        -- graphql = { "prettier" },
        -- java = { "google-java-format" },
        -- toml = { "taplo" },
        yaml = {},
        md = {},
        markdown = {},
        -- sh = {},
        -- javascript = { "prettier" },

        ["*"] = { "trim_newlines", "trim_whitespace" },
      },
      formatters = {
        goimports = {
          prepend_args = { "-local", "gitlab.pandadoc.com" },
        },
        -- hclfmt = {
        --   command = "hclfmt",
        -- },
        -- terragrunt_fmt = {
        --   command = "terragrunt",
        --   args = { "fmt", "-" },
        -- },
        taplo = {
          args = { "format", "-c", vim.fn.expand("~/.taplo.toml"), "-" },
        },
        -- mdformat = {
        --   command = "mdformat",
        --   args = { "--wrap", "80", "-" },
        -- },
      },
    },
  },
}
