return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.cursorword').setup()
    require('mini.hipatterns').setup()
    require('mini.statusline').setup()
    require('mini.tabline').setup()
    require('mini.trailspace').setup()
  end
}
