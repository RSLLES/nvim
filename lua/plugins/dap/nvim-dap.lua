return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		-- keymaps
		local km = vim.keymap -- for conciseness
		km.set("n", "<leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "Toogle a breakpoint" })

		km.set("n", "<leader>dB", function()
			dap.clear_breakpoints()
		end, { desc = "Clear all breakpoint(s)" })

		km.set("n", "<leader>dc", function()
			dap.continue()
		end, { desc = "Start/continue a debugging session" })

		km.set("n", "<leader>dr", function()
			dap.restart()
		end, { desc = "Restart debugging session" })

		km.set("n", "<leader>do", function()
			dap.step_over()
		end, { desc = "Step over" })

		km.set("n", "<leader>di", function()
			dap.step_into()
		end, { desc = "Step into" })

		km.set("n", "<leader>dp", function()
			dap.step_out()
		end, { desc = "Step out" })

		km.set("n", "<leader>dx", function()
			dap.terminate()
		end, { desc = "Terminate debugging session" })

		-- ui
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
	end,
}
