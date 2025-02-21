local M = {}

M.ui = {
  theme = "doomchad",
}

M.options = {
  nvChad = {
    -- nvchad specific options
  },
  user = {
    -- System clipboard
    clipboard = "unnamedplus",
    
    -- Line numbers
    number = true,
    relativenumber = true,
    
    -- Indentation
    expandtab = true,
    shiftwidth = 2,
    smartindent = true,
    tabstop = 2,
    softtabstop = 2,
    
    -- Search
    ignorecase = true,
    smartcase = true,
    
    -- Editor UI
    termguicolors = true,
    showmatch = true,
    signcolumn = "yes",
    
    -- File handling
    autoread = true,
    backup = false,
    writebackup = false,
    
    -- Better splitting
    splitbelow = true,
    splitright = true,
  }
}

-- For auto-formatting/linting, you'll want to set up conform.nvim
-- Add this to your plugins
M.plugins = {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require "configs.conform"
    end,
  }
}

return M
