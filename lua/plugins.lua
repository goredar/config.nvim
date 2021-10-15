local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  git = { clone_timeout = 350 },
})

require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "lewis6991/impatient.nvim" })

  -- [[ tpope ]]
  use({
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-fugitive",
  })

  -- [[ Utility ]]
  use({
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "vim-scripts/genutils",
  })

  -- [[ UI ]]
  use({
    "levouh/tint.nvim",
    "hoob3rt/lualine.nvim",
    "kyazdani42/nvim-tree.lua",
    "lewis6991/gitsigns.nvim",
    { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" },
    "lewis6991/hover.nvim",
    {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-telescope/telescope-project.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
    },
  })

  -- [[ UX ]]
  use({
    "terrortylor/nvim-comment",
    "windwp/nvim-autopairs",
    "Vonr/align.nvim",
    "andymass/vim-matchup",
    "farmergreg/vim-lastplace",
    "akinsho/toggleterm.nvim",
    "goolord/alpha-nvim",
    "ggandor/leap.nvim",
  })

  -- [[ Look and Feel ]]
  use({
    { "catppuccin/nvim", as = "catppuccin" },
    "kyazdani42/nvim-web-devicons",
    "romgrk/barbar.nvim",
    { "echasnovski/mini.indentscope", branch = "stable" },
  })

  -- [[ LSP ]]
  use({
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "onsails/lspkind-nvim",
    "ray-x/lsp_signature.nvim",
    "folke/lsp-colors.nvim",

    "jose-elias-alvarez/null-ls.nvim",
    "folke/neodev.nvim",
    "b0o/schemastore.nvim",
  })

  -- [[ Treesitter ]]
  use({
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "p00f/nvim-ts-rainbow",
    "romgrk/nvim-treesitter-context",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "ray-x/cmp-treesitter",
  })

  -- [[ Completion ]]
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-rg",
    },
  })

  -- [[ Snippets ]]
  use({
    "saadparwaiz1/cmp_luasnip",
    {
      "L3MON4D3/LuaSnip",
      run = "make install_jsregexp",
    },
    "rafamadriz/friendly-snippets",
  })

  -- [[ Languages ]]
  use({
    -- use('andrewstuart/vim-kubernetes')
    "jose-elias-alvarez/typescript.nvim",
    "sheerun/vim-polyglot",
    "simrat39/rust-tools.nvim",
    {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    },
    {
      "editorconfig/editorconfig-vim",
      setup = function()
        vim.g.EditorConfig_max_line_indicator = ""
        vim.g.EditorConfig_preserve_formatoptions = 1
      end,
    },
  })

  -- [[ Stage ]]

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
