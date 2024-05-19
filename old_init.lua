local g = vim.g
local opt = vim.opt

g.mapleader = " "

-- opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.cmdheight = 0                                   -- hide commandline unless needed
opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
opt.conceallevel = 2
opt.confirm = true
opt.copyindent = true
opt.cursorline = true
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
opt.expandtab = true
opt.foldcolumn = "1"
opt.foldenable = false
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.history = 1000
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.infercase = true
opt.laststatus = 3
opt.number = true
opt.preserveindent = true
opt.pumheight = 10
opt.relativenumber = true
opt.shiftwidth = 2
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true })
opt.showmode = false
opt.showtabline = 2
opt.signcolumn = "yes"
opt.smartcase = true
opt.smoothscroll = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeout = true
opt.timeoutlen = 500
opt.title = true
opt.undolevels = 10000
opt.undofile = true
opt.updatetime = 300
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.wrap = false
opt.writebackup = false
opt.viewoptions = vim.tbl_filter(function(val)
  return val ~= "curdir"
end, vim.opt.viewoptions:get())

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { bold = true },
        functions = { bold = true },
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help" },
      dim_inactive = true,
    },
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          compile_file_suffix = "_compiled",
          hide_end_of_buffer = true,
          hide_nc_statusline = true,
          transparent = false,
          terminal_colors = true,
          dim_inactive = true,
          module_default = true,
          styles = {
            comments = "italic",
            functions = "bold",
            keywords = "bold",
            variables = "NONE",
            conditionals = "bold",
            constants = "bold",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "bold,italic",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
          darken = {
            floats = false,
            sidebars = {
              enabled = true,
              list = {},
            },
          },
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    lazy = true,
    priority = 1000,
    name = "rose-pine",
    opts = {
      variant = "auto",
      dark_variant = "main",
      dim_inactive_windows = true,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "", -- can be "hard", "soft" or empty string
      dim_inactive = true,
    },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    priority = 1000,
  },
  { "pineapplegiant/spaceduck",    lazy = true, priority = 1000 },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = false,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
      terminal_colors = true,
    },
  },
  {
    "oxfist/night-owl.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      bold = true,
      italics = true,
      underline = true,
      undercurl = true,
      transparent_background = false,
    },
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
    opts = { animation = false },
  },
  { {
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
  } },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")

      local colors = {
        bg = "#202328",
        fg = "#bbc2cf",
        yellow = "#ECBE7B",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#98be65",
        orange = "#FF8800",
        violet = "#a9a1e1",
        magenta = "#c678dd",
        blue = "#51afef",
        red = "#ec5f67",
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end
      ins_left({
        function()
          return "▊"
        end,
        color = { fg = colors.blue },
        padding = { left = 0, right = 1 },
      })
      ins_left({
        function()
          return ""
        end,
        color = function()
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            ["␖"] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            ["␓"] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      })
      ins_left({
        "filesize",
        cond = conditions.buffer_not_empty,
      })
      ins_left({
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = "bold" },
      })
      ins_left({ "location" })
      ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
      })
      ins_left({
        function()
          return "%="
        end,
      })
      ins_left({
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " LSP:",
        color = { fg = "#ffffff", gui = "bold" },
      })
      ins_right({
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      })
      ins_right({
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green, gui = "bold" },
      })
      ins_right({
        "branch",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
      })
      ins_right({
        "diff",
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      })
      ins_right({
        function()
          return "▊"
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      })
      lualine.setup(config)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "andymass/vim-matchup", { "m-demare/hlargs.nvim", opts = {} } },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "diff",
          "go",
          "gomod",
          "gosum",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "org",
          "python",
          "regex",
          "sql",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "zig",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        matchup = { enable = true },
        indent = {
          enable = true,
          disable = { "python" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = { disable_filetype = { "TelescopePrompt", "vim" } },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-nvim-lua",
      "windwp/nvim-autopairs",
      "nvim-orgmode/orgmode",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({ mode = "text_symbol" }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
          { name = "orgmode" },
          { name = "treesitter" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
        view = {
          entries = { name = "wildmenu", separator = "|" },
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "jubnzv/virtual-types.nvim",
      { "VidocqH/lsp-lens.nvim",        opts = {} },
      { "folke/neodev.nvim",            opts = {} },
      { "j-hui/fidget.nvim",            opts = { progress = { ignore_done_already = true, ignore_empty_message = true } } },
      { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    config = function()
      require("mason").setup()

      local servers = {
        biome = {
          settings = {},
          filetypes = {
            "javascript",
            "javascriptreact",
            "json",
            "jsonc",
            "typescript",
            "typescript.tsx",
            "typescriptreact",
            "astro",
            "svelte",
            "vue",
          },
        },
        cssls = { settings = {}, filetypes = { "css", "scss", "less" } },
        cssmodules_ls = {
          settings = {},
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
        emmet_ls = {
          settings = {},
          filetypes = {
            "astro",
            "css",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
          },
        },
        eslint = {
          settings = {},
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
            "svelte",
            "astro",
          },
        },
        fennel_ls = { settings = {}, filetypes = { "fennel" } },
        gopls = { settings = {}, filetypes = { "go", "gomod", "gowork", "gotmpl" } },
        html = { settings = {}, filetypes = { "html", "templ" } },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = { checkThirdParty = false, library = vim.env.VIMRUNTIME },
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
              telemetry = { enable = false },
            },
          },
          filetypes = { "lua" },
        },
        tsserver = {
          settings = {},
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
        },
        ["typescript-tools"] = {
          settings = {
            separate_diagnostic_server = true,
            publish_diagnostic_on = "insert_leave",
            expose_as_code_action = "all",
            tsserver_path = nil,
            -- npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
            tsserver_plugins = { "@styled/typescript-styled-plugin" },
            tsserver_max_memory = "auto",
            tsserver_format_options = {},
            tsserver_file_preferences = {},
            tsserver_locale = "en",
            -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
            complete_function_calls = true,
            include_completions_with_insert_text = true,
            -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
            -- possible values: ("off"|"all"|"implementations_only"|"references_only")
            code_lens = "off",
            -- by default code lenses are displayed on all referencable values and for some of you it can
            -- be too much this option reduce count of them by removing member references from lenses
            disable_member_code_lens = true,
            jsx_close_tag = {
              enable = true,
              filetypes = { "javascriptreact", "typescriptreact", "html" },
            },
          },
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
        },
        zls = {
          settings = {},
          filetypes = { "zls", "zir" },
        },
      }

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local virtual_types = require("virtualtypes")

      local on_attach = function(client, bufnr)
        virtual_types.on_attach()

        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = "rounded",
              source = "always",
              prefix = " ",
              scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
          end,
        })
      end

      mason_lspconfig.setup_handlers({
        function(server_name)
          local server = servers[server_name] or {}

          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = server.settings or {},
            filetypes = server.filetypes or {},
          })
        end,
      })

      require("typescript-tools").setup({
        on_attach = on_attach,
        settings = servers["typescript-tools"].settings or {},
        filetypes = servers["typescript-tools"].filetypes or {}
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        float = { source = "if_many" },
      })

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "biome", "biome-check", "prettierd", "prettier" } },
        typescript = { { "biome", "biome-check", "prettierd", "prettier" } },
        javascriptreact = { { "biome", "biome-check", "prettierd", "prettier" } },
        typescriptreact = { { "biome", "biome-check", "prettierd", "prettier" } },
        html = { { "biome", "biome-check", "prettierd", "prettier" } },
        css = { { "biome", "biome-check", "prettierd", "prettier" } },
        json = { { "biome", "biome-check", "prettierd", "prettier" } },
        fennel = { "fnlfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { layout = { align = "center" } },
  },
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit", "DiffviewOpen" },
    dependencies = {
      "sindrets/diffview.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      { "akinsho/git-conflict.nvim", opts = {} },
      {
        "lewis6991/gitsigns.nvim",
        config = function()
          local gitsigns = require("gitsigns")
          gitsigns.setup({
            signs = {
              add = { text = "┃" },
              change = { text = "┃" },
              delete = { text = "_" },
              topdelete = { text = "‾" },
              changedelete = { text = "~" },
              untracked = { text = "┆" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
              follow_files = true,
            },
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = true,
            current_line_blame_opts = {
              virt_text = true,
              virt_text_pos = "eol",
              delay = 1000,
              ignore_whitespace = false,
              virt_text_priority = 100,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            current_line_blame_formatter_opts = {
              relative_time = true,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            max_file_length = 40000,
            preview_config = {
              border = "single",
              style = "minimal",
              relative = "cursor",
              row = 0,
              col = 1,
            },
            on_attach = function(bufnr)
              local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
              end
              map("n", "]c", function()
                if vim.wo.diff then
                  vim.cmd.normal({ "]c", bang = true })
                else
                  gitsigns.nav_hunk("next")
                end
              end)
              map("n", "[c", function()
                if vim.wo.diff then
                  vim.cmd.normal({ "[c", bang = true })
                else
                  gitsigns.nav_hunk("prev")
                end
              end)
              map("n", "<leader>hs", gitsigns.stage_hunk)
              map("n", "<leader>hr", gitsigns.reset_hunk)
              map("v", "<leader>hs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end)
              map("v", "<leader>hr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
              end)
              map("n", "<leader>hS", gitsigns.stage_buffer)
              map("n", "<leader>hu", gitsigns.undo_stage_hunk)
              map("n", "<leader>hR", gitsigns.reset_buffer)
              map("n", "<leader>hp", gitsigns.preview_hunk)
              map("n", "<leader>hb", function()
                gitsigns.blame_line({ full = true })
              end)
              map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
              map("n", "<leader>hd", gitsigns.diffthis)
              map("n", "<leader>hD", function()
                gitsigns.diffthis("~")
              end)
              map("n", "<leader>td", gitsigns.toggle_deleted)
              map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
          })
        end,
      },
    },
    opts = {},
  },
  { "akinsho/toggleterm.nvim",     opts = { open_mapping = [[<c-t>]] }, event = "VeryLazy" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = { { "-", "<cmd>Oil<cr>", desc = "open file editor" } },
  },
  { "norcalli/nvim-colorizer.lua", opts = { "*" } },
  {
    "folke/trouble.nvim",
    branch = "dev", -- IMPORTANT!
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {},
  },
  {
    "dundalek/parpar.nvim",
    dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
    ft = { "fennel" },
    opts = {},
  },
  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    opts = {},
  },
  {
    "lukas-reineke/headlines.nvim",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
  {
    "kevinhwang91/nvim-hlslens",
    opts = { calm_down = true, nearest_only = true, nearest_float_when = "always" },
    event = "VeryLazy",
  },
  { "lewis6991/satellite.nvim",    opts = {},          event = "VeryLazy" },
  { "tzachar/highlight-undo.nvim", opts = {},          event = "VeryLazy" },
  { "karb94/neoscroll.nvim",       event = "VeryLazy", opts = {} },
}, {})

-- cyberdream
-- github_dark
-- github_dark_default
-- github_dark_dimmed
-- github_dark_high_contrast
-- github_dark_colorblind
-- github_dark_tritanopia
-- gruvbox
-- night-owl
-- onedark
-- onedark_dark
-- onedark_vivid
-- oxocarbon
-- rose-pine-moon
-- spaceduck
-- tokyonight
-- tokyonight-night
-- tokyonight-storm
-- tokyonight-moon
vim.cmd("colorscheme cyberdream")
