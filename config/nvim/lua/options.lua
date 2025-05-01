-- First load NvChad defaults if you want to keep them
pcall(require, "nvchad.options")

-- Now set clipboard integration
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard
vim.opt.mouse = "a"                -- Enable mouse in all modes

-- Confirm Neovim has clipboard support
if vim.fn.has('clipboard') == 0 then
  vim.notify("Clipboard support not available! Install xclip/wl-clipboard on Linux or pbcopy/pbpaste on macOS", vim.log.levels.WARN)
end
