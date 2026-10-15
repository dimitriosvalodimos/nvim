return {
  { "catppuccin/nvim", name = "catppuccin", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "folke/noice.nvim", opts = { cmdline = { enabled = false }, messages = { enabled = false } } },
  { "folke/tokyonight.nvim", enabled = false },
  { "neovim/nvim-lspconfig", opts = { inlay_hints = { enabled = false } } },
  { "saghen/blink.cmp", opts = { completion = { ghost_text = { enabled = false } } } },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      picker = { enabled = false },
    },
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
      { "<leader>fe", false },
      { "<leader>fE", false },
    },
  },
}
