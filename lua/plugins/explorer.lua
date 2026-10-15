return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-mini/mini.icons", "refractalize/oil-git-status.nvim", "JezerM/oil-lsp-diagnostics.nvim" },
    opts = {
      columns = { "icon", "permissions", "size", "mtime" },
      default_file_explorer = true,
      lsp_file_methods = { enabled = true, timeout_ms = 1000, autosave_changes = "unmodified" },
      view_options = { show_hidden = true },
      win_options = { signcolumn = "yes:2", statuscolumn = "" },
    },
    config = function(_, opts)
      require("oil").setup(opts)
      require("oil-git-status").setup({ show_ignored = false })
      require("oil-lsp-diagnostics").setup({ count = true, parent_dirs = true })
    end,
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
  },
}
