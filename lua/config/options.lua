local g = vim.g
local opt = vim.opt
g.mapleader = " "
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
opt.background = "dark"
opt.backupcopy = "yes"
opt.breakindent = true
opt.breakindentopt = "list:-1"
opt.clipboard:append("unnamedplus")
opt.cmdwinheight = 30
opt.colorcolumn = "+0"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.diffopt = { "internal", "filler", "closeoff", "inline:word", "linematch:40" }
opt.equalalways = true
opt.expandtab = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.infercase = true
opt.laststatus = 3
opt.modeline = false
opt.modelines = 0
opt.number = true
opt.numberwidth = 3
opt.preserveindent = true
opt.pumheight = 15
opt.redrawtime = 150
opt.ruler = false
opt.shiftround = true
opt.shiftwidth = 0
opt.shortmess = "acstFOSW"
opt.showtabline = 2
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = -1
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.title = true
opt.titlestring = "nvim: %f"
opt.undofile = true
opt.wildignore = "*.o"
opt.wildmode = "longest:full"
opt.wildoptions = "pum"
opt.wrap = false
opt.writebackup = false
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("config.pack", { clear = true }),
	callback = function(args)
		local spec = args.data.spec
		if not spec then
			return
		end
		if args.data.kind ~= "update" then
			return
		end
		if spec.name == "nvim-treesitter" then
			vim.schedule(function()
				vim.cmd(":TSUpdate<cr>")
			end)
		end
	end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("config_highlight_yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})
