local ok, lsp_signature = pcall(require, "lsp_signature")
if not ok then
  return
end

local cfg = {
  bind = true,
  handler_opts = {
    border = "rounded",
  },
  floating_window = false,
}
require("lsp_signature").setup(cfg)
