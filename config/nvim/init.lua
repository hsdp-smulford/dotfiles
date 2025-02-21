-- Set leader key early
vim.g.mapleader = " "

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Load Lazy.nvim with configuration
require("lazy").setup({
  ----------------------
  -- Plugin Definitions
  ----------------------
  -- Core plugins
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- UI enhancements
  { "nvim-lualine/lualine.nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "lewis6991/gitsigns.nvim" },

  -- LSP and Autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- File explorer
  { "kyazdani42/nvim-tree.lua" },

  -- Git integration
  { "tpope/vim-fugitive" },

  -- Color schemes
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      vim.cmd([[colorscheme tokyonight]])
    end
  },

  -- Utility plugins
  { "numToStr/Comment.nvim", config = function()
      require("Comment").setup()
    end
  },

  -------------------------
  -- Additional Settings
  -------------------------
}, {
  defaults = { lazy = true },
  install = { colorscheme = { "tokyonight", "gruvbox" } },
  ui = { border = "rounded" },
})

-- Load custom options and mappings safely
pcall(require, "core.options")
pcall(require, "core.mappings")

