return {
	"mfussenegger/nvim-dap",
	lazy = true,
	config = function()
		local dap = require("dap")
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: step out" })
		vim.keymap.set("n", "<F17>", dap.terminate, { desc = "Debug: Stop" }) -- Shift+F5
		vim.keymap.set("n", "<leader>tB", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
		vim.keymap.set("n", "<leader>dB", dap.clear_breakpoint, { desc = "Debug: clear breakpoint" })
	end,
}
