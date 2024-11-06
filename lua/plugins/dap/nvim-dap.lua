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

		-- ui
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)

		-- configurations
		local function get_python_interpeter_path()
			local python_path = python_utils.get_python_interpeter_path()
			vim.notify("Python debugger will use " .. python_path, vim.log.levels.INFO)
			return python_path
		end

		local function get_module_path()
			local module_path = python_utils.get_module_path()
			vim.notify("Debugging module " .. module_path, vim.log.levels.INFO)
			return module_path
		end

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Current module (justMyCode = true)",
				module = get_module_path,
				pythonPath = get_python_interpeter_path,
				console = "integratedTerminal",
				justMyCode = true,
			},
			{
				type = "python",
				request = "launch",
				name = "Current module (justMyCode = false)",
				module = get_module_path,
				pythonPath = get_python_interpeter_path,
				console = "integratedTerminal",
				justMyCode = false,
			},
		}
	end,
}
