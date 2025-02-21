local options = {
  lsp_fallback = true,
  
  -- Enable format on save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },
    
    -- Web development
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    markdown = { "prettier" },
    
    -- Python
    python = { "black" },
    
    -- Go
    go = { "gofmt" },
    
    -- Rust
    rust = { "rustfmt" },
    
    -- Shell scripts
    sh = { "shfmt" },
    
    -- YAML/TOML
    yaml = { "prettier" },
    toml = { "taplo" },
    
    -- Misc
    ["*"] = { "trim_whitespace", "trim_newlines" },
  },
  
  -- Set up formatter options
  formatters = {
    prettier = {
      prepend_args = { "--single-quote", "--jsx-single-quote" },
    },
    stylua = {
      prepend_args = { "--indent-type", "spaces", "--indent-width", "2" },
    },
    black = {
      prepend_args = { "--line-length", "88" },
    },
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
  },
}

require("conform").setup(options)
