-- lua/plugins/init.lua
local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  -- Core plugins that come with NvChad
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("custom.configs.null-ls")
      end,
    },
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },
  
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },
  
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
  
  -- DevOps Specific Plugins
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "terraform-ls",
        "ansible-language-server",
        "docker-langserver",
        "gopls",
        "pyright",
        "yaml-language-server",
        "bash-language-server",
        
        -- Linters & Formatters
        "golangci-lint",
        "terraform-fmt",
        "ansible-lint",
        "shellcheck",
        "hadolint",
        "tflint",
      },
    },
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
    },
    config = function()
      require("dapui").setup()
      require("dap-go").setup()
      
      -- Set up keymaps
      vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Continue" })
    end,
  },
  
  -- Infrastructure as Code support
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "tf", "hcl" },
    init = function()
      vim.g.terraform_fmt_on_save = 1
      vim.g.terraform_align = 1
    end,
  },
  
  {
    "pearofducks/ansible-vim",
    ft = { "yaml.ansible", "ansible" },
  },
  
  {
    "towolf/vim-helm",
    ft = { "helm", "yaml" },
  },
  
  {
    "chr4/nginx.vim",
    ft = "nginx",
  },
  
  -- Git enhancements
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },
  
  {
    "f-person/git-blame.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.g.gitblame_enabled = 0 -- Disable by default, toggle with :GitBlameToggle
    end,
  },
  
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("octo").setup()
    end,
  },
  
  -- Diagnostics and testing
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go"),
          require("neotest-python"),
        },
      })
    end,
    cmd = {
      "Neotest",
    },
  },
  
  -- AI Assistance
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "github/copilot.vim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("copilot_cmp").setup()
    end,
    event = { "InsertEnter" },
  },
  
  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
      
      -- Custom terminal commands for DevOps tools
      local Terminal = require("toggleterm.terminal").Terminal
      
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
      vim.api.nvim_set_keymap("n", "<leader>gg", "
