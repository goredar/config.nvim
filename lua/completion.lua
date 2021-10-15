local vim = vim
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local types = require("cmp.types")
local mapping = cmp.mapping

-- require("cmp_nvim_ultisnips").setup({})

-- local function jump_forwards(fallback)
--   cmp_ultisnips_mappings.compose({ "jump_forwards", "select_next_item" })(fallback)
-- end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
    }),
  },
  mapping = {
    ["<C-d>"] = mapping(mapping.scroll_docs(8), { "i" }),
    ["<C-u>"] = mapping(mapping.scroll_docs(-8), { "i" }),
    ["<C-Space>"] = mapping.complete(),
    ["<C-c>"] = mapping.abort(),
    ["<C-f>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<C-j>"] = mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    -- { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
    -- { name = "luasnip" },
    -- { name = "tmux" },
    -- { name = "rg" },
    -- { name = "git" },
    -- { name = "calc" },
  },

  window = { documentation = cmp.config.window.bordered() },
  experimental = { ghost_text = false, custom_menu = true },
})
