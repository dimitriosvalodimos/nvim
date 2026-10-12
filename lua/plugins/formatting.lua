return {
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { biome = {} } },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Use only the first available formatter, never Biome followed by Prettier.
      for _, ft in ipairs({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
        "graphql",
      }) do
        opts.formatters_by_ft[ft] = { "biome-check", "prettier", stop_after_first = true }
      end
      for _, ft in ipairs({
        "html",
        "vue",
        "scss",
        "less",
        "markdown",
        "markdown.mdx",
        "yaml",
        "handlebars",
      }) do
        opts.formatters_by_ft[ft] = { "prettier" }
      end

      opts.formatters["biome-check"] = {
        -- A globally installed Biome alone must not opt every project into Biome.
        condition = function(self, ctx)
          if vim.fs.root(ctx.dirname, { "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" }) then
            return true
          end
          local local_biome = require("conform.util").find_executable({ "node_modules/.bin/biome" }, "")
          return local_biome(self, ctx) ~= ""
        end,
      }
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "biome", "prettier" } },
  },
}
