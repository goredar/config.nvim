return {
  {
    "statiolake/rust-import.nvim",
    ft = "rust",
    config = function()
      require("rust-import").setup({
        -- Enable debug logging to file
        debug = false,

        -- Prefer `as _` suffix for trait imports (e.g., `use rand::Rng as _`)
        prefer_trait_as_underscore = true,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rust_organize_imports", "rustfmt", lsp_format = "fallback" },
        -- markdown = { "write_good", "markdownlint-cli2" },
        -- proto = { "buf" },
        json = { "jq" },
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
        cpp = { "clang_format" },

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
        rust_organize_imports = {
          meta = {
            url = "https://github.com/statiolake/rust-import.nvim",
            description = "Organize Rust imports",
          },
          format = function(self, ctx, lines, callback)
            require("rust-import").format(ctx.buf, callback)
          end,
        },
        -- mdformat = {
        --   command = "mdformat",
        --   args = { "--wrap", "80", "-" },
        -- },
      },
    },
  },
}
