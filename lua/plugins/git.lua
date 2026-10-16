return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = { "ibhagwan/fzf-lua", "sindrets/diffview.nvim" },
    opts = {
      integrations = {
        fzf_lua = true,
        snacks = false,
        diffview = true,
      },
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
