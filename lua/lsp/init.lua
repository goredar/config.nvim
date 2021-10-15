local vim = vim
local lsp = require("lspconfig")

require("lsp_signature").setup({ bind = true, hint_enable = false })
require("lsp-colors").setup()

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local on_attach = function(client, bufnr)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

  vim.cmd([[ set formatoptions-=cro ]])

  lsp_highlight_document(client)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- virtual_text = {prefix = "", source = "always"},
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = true,
  severity_sort = true,
})

local signs = {
  { name = "DiagnosticSignError", text = "●" },
  { name = "DiagnosticSignWarn", text = "●" },
  { name = "DiagnosticSignHint", text = "●" },
  { name = "DiagnosticSignInfo", text = "●" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = true,
  signs = { active = signs },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

-- saga.init_lsp_saga({
--   code_action_icon = "❯",
--   code_action_lightbulb = {
--     enable = true,
--     sign = true,
--     enable_in_insert = true,
--     sign_priority = 20,
--     virtual_text = false,
--   },
-- })

require("lspsaga").setup({
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = false,
    sign_priority = 40,
    virtual_text = false,
  },
  diagnostic = {
    show_code_action = false,
    show_source = false,
    jump_num_shortcut = false,
  },
})

require("lspconfig").jsonls.setup({
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({})

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({})
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function()
  --   require("rust-tools").setup({})
  -- end,
})
