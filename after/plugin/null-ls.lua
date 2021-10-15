---@type dsdsdsd
local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.commitlint,
    null_ls.builtins.diagnostics.gitlint,
    null_ls.builtins.diagnostics.hadolint,
    -- null_ls.builtins.diagnostics.misspell,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgres" },
    }),
    null_ls.builtins.diagnostics.terraform_validate,

    null_ls.builtins.formatting.cbfmt,
    -- null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.ktlint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.prettier.with({
      disabled_filetypes = { "yaml", "json" },
    }),
    -- null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.hclfmt,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.trim_newlines.with({
      disabled_filetypes = { "yaml", "json" },
    }),
    null_ls.builtins.formatting.trim_whitespace.with({
      disabled_filetypes = { "yaml", "json" },
    }),
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports.with({
      extra_args = { "-local", "gitlab.pandadoc.com" },
    }),
    -- null_ls.builtins.formatting.golines,
    -- null_ls.builtins.formatting.sqlfluff.with({
    --   extra_args = { "--dialect", "postgres" },
    -- }),
    null_ls.builtins.formatting.terraform_fmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
