return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- keys[#keys + 1] = { "<c-k>", false, mode = "i" }

      opts.diagnostics.underline = false
      opts.diagnostics.virtual_text = false
      opts.diagnostics.float = {
        focusable = false,
        border = "rounded",
        source = "always",
        header = "",
      }
    end,
  },
}
