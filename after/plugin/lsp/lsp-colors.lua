local ok, lsp_colors = pcall(require, "lsp-colors")
if not ok then
  return
end

local cfg = {}

lsp_colors.setup(cfg)
