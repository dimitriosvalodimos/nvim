return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    local drawer = function()
      local floor, width, height = math.floor, vim.o.columns, vim.o.lines
      local half_height = floor(0.5 * height)
      return {
        anchor = "NW",
        width = width,
        height = half_height,
        row = height - half_height,
        col = 0,
      }
    end
    require("mini.ai").setup()
    require("mini.comment").setup()
    require("mini.completion").setup()
    require("mini.extra").setup()
    require("mini.git").setup()
    require("mini.icons").setup()
    require("mini.move").setup()
    require("mini.pairs").setup()
    require("mini.pick").setup({ window = { config = drawer } })
    require("mini.statusline").setup()
    require("mini.tabline").setup()
  end,
}
