local ok, indentscope = pcall(require, "mini.indentscope")
if not ok then
  return
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

indentscope.setup({
  -- symbol = "▏",
  draw = {
    delay = 50,
    priority = 2,
  },
})
