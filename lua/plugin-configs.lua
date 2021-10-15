local catppuccin = require("catppuccin")
catppuccin.setup({ flavour = "mocha" })
-- catppuccin.setup({ flavour = "macchiato" })
catppuccin.load()

-- vim.cmd([[colorscheme catppuccin-macchiato]])

require("nvim-web-devicons").setup()

require("gitsigns").setup()

require("alpha").setup(require("alpha.themes.startify").opts)

require("nvim_comment").setup({
  -- Linters prefer comment and line to have a space in between markers
  marker_padding = true,
  -- should comment out empty or whitespace only lines
  comment_empty = true,
  -- Should key mappings be created
  create_mappings = true,
  -- Normal mode mapping left hand side
  line_mapping = "gcc",
  -- Visual/Operator mapping left hand side
  operator_mapping = "gc",
  -- Hook function to call before commenting takes place
  hook = nil,
})

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("toggleterm").setup({
  open_mapping = [[<c-X>]],
  -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
  direction = "float",
})
