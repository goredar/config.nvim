return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        yaml = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
        ["<C-f>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      },
      current_line_blame_formatter = "  [<author_time:%Y-%m-%d>] <author> | <summary>",
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Linters
        "actionlint",
        "mypy",
        "golangci-lint",
        "revive",
        "vale",
        "markdownlint-cli2",
        "codespell",
        "cspell",

        -- Formatters
        "ruff",
        "buf",
        "jq",
        "prettier",
        "google-java-format",
        "taplo",
        "goimports",
      },
    },
  },
}
