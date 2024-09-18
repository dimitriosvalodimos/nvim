return {
	"ms-jpq/coq_nvim",
	lazy = true,
	branch = "coq",
	build = ":COQdeps",
	dependencies = { { "ms-jpq/coq.artifacts", branch = "artifacts" } },
	init = function()
		vim.g.coq_settings = {
			auto_start = "shut-up",
			display = {
				icons = {
					mappings = {
						Text = "",
						Method = "󰆧",
						Function = "󰊕",
						Constructor = "",
						Field = "󰇽",
						Variable = "󰂡",
						Class = "󰠱",
						Interface = "",
						Module = "",
						Property = "󰜢",
						Unit = "",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈙",
						Reference = "",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "󰅲",
					},
				},
				pum = {
					fast_close = false,
					kind_context = { " ", " " },
					source_context = { " ", " " },
				},
				ghost_text = {
					enabled = true,
					context = { "", "" },
				},
			},
		}
	end,
}
