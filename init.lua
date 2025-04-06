local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ";"
opt.background = "light" -- dark, light
opt.backupcopy = "yes"
opt.breakindent = true
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = true
opt.expandtab = true
opt.grepformat = "%f:%l:%m"
opt.grepprg = "rg --vimgrep -S "
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 2
opt.number = true
opt.preserveindent = true
opt.pumheight = 10
opt.scrolloff = 5
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess = "c"
opt.sidescrolloff = 5
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.wrap = false

local function map(mode, lhs, rhs, opts)
	if type(opts) == "string" then
		vim.keymap.set(mode, lhs, rhs, { desc = opts })
	else
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

map("v", "<", "<gv", "dedent")
map("v", ">", ">gv", "indent")
map("i", "<A-u>", "<c-r>=trim(system('uuidgen'))<cr>", "uuid")
map("n", "<A-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", "uuid")
map("n", "-", ":Explore %:p:h<cr>", "open file manager")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local servers = {
	cssls = {},
	html = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { globals = { "vim" } },
				runtime = { version = "LuaJIT" },
				telemetry = { enable = false },
				workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
			},
		},
	},
	rust_analyzer = {},
	ts_ls = {},
}

local function feedkeys(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end

map("i", "<cr>", function()
	return pumvisible() and "<C-y>" or "<cr>"
end, { expr = true })

map("i", "<C-n>", function()
	return pumvisible() and feedkeys("<C-n>")
end, "Trigger/select next completion")

map("i", "<c-space>", function()
	if next(vim.lsp.get_clients({ bufnr = 0 })) then
		vim.lsp.completion.get()
	else
		if vim.bo.omnifunc == "" then
			feedkeys("<C-x><C-n>")
		else
			feedkeys("<C-x><C-o>")
		end
	end
end, "trigger completion")

map({ "i", "s" }, "<Tab>", function()
	if pumvisible() then
		feedkeys("<C-n>")
	elseif vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
	else
		feedkeys("<Tab>")
	end
end, {})

map({ "i", "s" }, "<S-Tab>", function()
	if pumvisible() then
		feedkeys("<C-p>")
	elseif vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
	else
		feedkeys("<S-Tab>")
	end
end, {})

local diagnostic_config = { severity_sort = true, virtual_lines = false, virtual_text = true }
map("n", "<leader>k", function()
	vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
		callback = function()
			vim.diagnostic.config(diagnostic_config)
			return true
		end,
	})
end)

require("lazy").setup({
	{ "Mofiqul/vscode.nvim", lazy = true, priority = 1000, opts = { italic_comments = false } },
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		lazy = false,
		keys = { { "<leader>gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "toggle git blame" } },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { disable_filetype = { "TelescopePrompt", "vim" }, map_cr = true, enable_check_bracket_line = false },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = { "diff", "lua", "luadoc", "markdown", "markdown_inline", "vimdoc" },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		opts = { { "ivy" }, winopts = { border = "none", preview = { border = "none" } } },
		keys = {
			{ "<leader>ff", ":silent FzfLua files<cr>", desc = "find files" },
			{ "<leader>fr", ":silent FzfLua resume<cr>", desc = "resume search" },
			{ "<leader>fb", ":silent FzfLua buffers<cr>", desc = "find buffer" },
			{ "<leader>fg", ":silent FzfLua live_grep<cr>", desc = "find word" },
			{ "<leader>fh", ":silent FzfLua helptags<cr>", desc = "find helptag" },
			{ "<leader>fk", ":silent FzfLua keymaps<cr>", desc = "find keymap" },
			{ "<leader>/", ":silent FzfLua lgrep_curbuf<cr>", desc = "find in buffer" },
		},
	},
	{
		"williamboman/mason.nvim",
		dependencies = { "neovim/nvim-lspconfig", "ibhagwan/fzf-lua" },
		config = function()
			local fzf = require("fzf-lua")
			local lspconfig = require("lspconfig")
			require("mason").setup()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.semanticTokens.multilineTokenSupport = true
			vim.diagnostic.config({ severity_sort = true, virtual_text = true })

			for server, config in pairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
					flags = { debounce_text_changes = 150 },
					settings = config.settings or {},
					init_options = config.init_options or {},
				})
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
				callback = function(event)
					local buf = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if not client or not client:supports_method("textDocument/completion") then
						return
					end
					local chars = {}
					for i = 32, 126 do
						table.insert(chars, string.char(i))
					end
					client.server_capabilities.completionProvider.triggerCharacters = chars
					vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
					map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf })
					map("n", "<leader>gr", fzf.lsp_references, { buffer = buf })
					map("n", "<leader>gd", fzf.lsp_definitions, { buffer = buf })
					map("n", "<leader>gD", fzf.lsp_typedefs, { buffer = buf })
					map("n", "<leader>gI", fzf.lsp_implementations, { buffer = buf })
					map("n", "<leader>ca", fzf.lsp_code_actions, { buffer = buf })
					map("n", "<leader>xx", fzf.diagnostics_document, { buffer = buf })
					map("n", "<leader>XX", fzf.diagnostics_workspace, { buffer = buf })
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = { lsp_format = true, async = false },
			formatters_by_ft = {
				css = { "prettier", lsp_format = "fallback" },
				html = { "prettier", lsp_format = "fallback" },
				javascript = { "prettier", lsp_format = "fallback" },
				javascriptreact = { "prettier", lsp_format = "fallback" },
				json = { "prettier", lsp_format = "fallback" },
				lua = { "stylua", lsp_format = "fallback" },
				rust = { "rustfmt", lsp_format = "fallback" },
				typescript = { "prettier", lsp_format = "fallback" },
				typescriptreact = { "prettier", lsp_format = "fallback" },
			},
		},
	},
})

vim.cmd.colorscheme("vscode") -- default, vscode
