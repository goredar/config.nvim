return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        extension = {
          promql = "promql",
        },
      })
    end,
    opts = {
      ensure_installed = { "promql" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        promql = {
          -- Not available in Mason. Install separately and add to PATH:
          -- go install github.com/prometheus-community/promql-langserver/cmd/promql-langserver@latest
          -- Set LANGSERVER_PROMETHEUSURL for live metric and label completion.
          mason = false,
          cmd = { "promql-langserver" },
          filetypes = { "promql" },
          root_markers = { ".git" },
        },
      },
    },
  },
}
