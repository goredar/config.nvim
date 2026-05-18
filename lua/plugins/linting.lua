return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "mypy" },
        go = { "golangcilint", "revive" },
        markdown = { "vale", "markdownlint-cli2" },
        ["*"] = { "codespell", "cspell" },
        ["yaml.ghaction"] = { "actionlint" },
      },
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("$HOME/.config/markdownlint-cli2.jsonc"), "--" },
        },
      },
    },
  },
}
