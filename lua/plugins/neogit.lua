return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "folke/snacks.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      integrations = { snacks = true, diffview = true },
    },
    keys = {
      {
        "<leader>gn",
        function()
          require("neogit").open({ cwd = LazyVim.root.git() })
        end,
        desc = "Neogit (Root Dir)",
      },
    },
  },
}
