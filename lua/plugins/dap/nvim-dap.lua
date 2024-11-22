return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		local python_utils = require("utils.python")

		-- keymaps
		local km = vim.keymap -- for conciseness
		km.set("n", "<leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle a breakpoint" })

		km.set("n", "<leader>dB", function()
			dap.clear_breakpoints()
		end, { desc = "Clear all breakpoint(s)" })

		km.set("n", "<leader>dC", function()
			dap.run_last()
		end, { desc = "Re-run the last debug configurations than previously ran." })

		km.set("n", "<leader>dc", function()
			dap.continue()
		end, { desc = "Run/continue a debugging session" })

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

		km.set("n", "<leader>de", function()
			local buffer = vim.fn.getreg(0)
			-- vim.notify(buffer)
			dap.repl.execute(buffer)
		end, { desc = 'Execute text in register "0' })

		-- ui
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
	end,
}
