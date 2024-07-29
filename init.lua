local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = ","

opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0 -- don't hide bold/italic markers
opt.confirm = true -- ask to save changes
opt.copyindent = true
opt.cursorline = true
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.expandtab = true
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99 -- start with all code unfolded
opt.hlsearch = true
opt.ignorecase = true -- case insensitive searching
opt.inccommand = "nosplit" -- preview substitute
opt.infercase = true -- infer cases in keyword completion
opt.laststatus = 3 -- global statusline
opt.number = true
opt.numberwidth = 4
opt.preserveindent = true
opt.pumblend = 10 -- popup blend
opt.pumheight = 10 -- popup max height
opt.relativenumber = true
opt.scrolloff = 5 -- vertical buffer area on scroll
opt.shiftround = true
opt.shiftwidth = 2
-- opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sidescrolloff = 5 -- horizontal buffer area on scroll
opt.signcolumn = "yes" -- Always show the signcolumn
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.updatetime = 300
opt.timeoutlen = 300
opt.timeout = true
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.virtualedit = "block"
opt.wildmode = { "longest:full", "full" }
opt.wrap = false

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldmethod = "expr"
	opt.foldtext = ""
end

local disabled_plugins = {
	"2html_plugin",
	"tohtml",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for i = 1, #disabled_plugins do
	g["loaded_" .. disabled_plugins[i]] = true
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

vim.keymap.set("i", "<c-u>", "<c-r>=trim(system('uuidgen'))<cr>", { desc = "insert uuid at cursor" })
vim.keymap.set("n", "<c-u>", "i<c-r>=trim(system('uuidgen'))<cr><esc>", { desc = "insert uuid at cursor" })

vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "move line up" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "move line down" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line down" })

vim.keymap.set("v", "<", "<gv", { desc = "dedent" })
vim.keymap.set("v", ">", ">gv", { desc = "indent" })

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

require("lazy").setup({
  spec = {
    { 'nvim-tree/nvim-web-devicons', opts={} },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      dependencies = { "andymass/vim-matchup", "HiPhish/rainbow-delimiters.nvim", "windwp/nvim-ts-autotag" },
      config = function()
        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.configs').setup({
          ensure_installed = { "bash", "c", "cpp", "css", "diff", "go", "gomod", "gosum", "html", "javascript", "jsdoc", "json", "lua", "luadoc", "markdown", "markdown_inline", "regex", "rust", "sql", "svelte", "tsx", "typescript", "vim", "vimdoc", "zig" },
          auto_install = true,
          matchup = { enable = true },
          highlight = { enable = true },
        })
        require("rainbow-delimiters.setup").setup({})
        require('nvim-ts-autotag').setup({
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true
          },
        })
      end
    },
    {
      'nvim-telescope/telescope.nvim',
      event = "VimEnter",
      tag = '0.1.8',
      dependencies = { 
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
        }
      },
      config = function ()
        local telescope = require("telescope")
        telescope.setup({
          extensions = {
            ['ui-select'] = { require("telescope.themes").get_dropdown() },
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case" -- ignore_case, respect_case
            }
          }
        })
        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'find help' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'find keymapping' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find file' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'find current word' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'find diagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'resume search' })
        vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'find recent files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'find buffer' })
        vim.keymap.set('n', '<leader>/', function()
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })
        end, { desc = 'fuzzy find in buffer' })
        vim.keymap.set('n', '<leader>f/', function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end, { desc = 'find in open files' })
        vim.keymap.set('n', '<leader>fn', function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = 'find in neovim files' })
      end
    },
    {
      "williamboman/mason.nvim",
      dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
      config = function()
        local servers = {
          biome = { filetypes = {"javascript", "javascriptreact", "json", "typescript", "typescript.tsx", "typescriptreact", "svelte", "css"}, settings = {} },
          cssls = { filetypes = {"css"}, settings = {} },
          cssmodules_ls = { filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"}, settings = {} },
          css_variables = { filetypes = {"css"}, settings = {} },
          emmet_ls = { filetypes = {"css","html","javascriptreact","svelte", "typescriptreact",}, settings = {} },
          eslint = { filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx","svelte",}, settings = {} },
          gopls = { filetypes = {"go", "gomod", "gowork", "gotmpl"}, settings = {} },
          html = { filetypes = {"html", "templ" }, settings = {} },
          lua_ls = {
            filetypes = { "lua" },
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                runtime = { version = "LuaJIT" },
                telemetry = { enable = false },
                workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME }},
              }
            }
          },
          svelte = { filetypes = {"svelte"}, settings = {} },
          tsserver = { filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"}, settings = {} },
          zls = { filetypes = {"zig", "zir"}, settings = {} },
        }
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        -- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
        local lspconfig = require('lspconfig')
        require("mason").setup()
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
        mason_lspconfig.setup_handlers({
          function(server_name)
            local config = servers[server_name] or {}
            lspconfig[server_name].setup({
              capabilities = capabilities,
              filetypes = config.filetypes or {},
              settings = config.settings or {},
            })
          end
        })
      end
    },
  },
  install = {},
  checker = { enabled = true }
})
