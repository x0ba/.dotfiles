return {
  "catppuccin/nvim",
  priority = 1000,
  name = "catppuccin",
  opts = {},
  config = function()
    vim.cmd("colorscheme catppuccin")
  end,
}
