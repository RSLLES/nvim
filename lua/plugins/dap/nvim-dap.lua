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

		km.set("n", "<leader>dC", function()
			dap.run_last()
		end, { desc = "Re-runs the last debug configurations than previously ran." })

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

		-- tools
		-- Escape special characters in Lua patterns: ( ) . % + - * ? [ ^ $
		local function escape_pattern(text)
			return text:gsub("([%-%.%(%)%+%*%?%[%^%$])", "%%%1")
		end

		-- returns the path of the current file formated as a python module path
		local function get_module_path()
			local file_path = vim.fn.expand("%:p")
			local cwd = vim.fn.getcwd()
			local cwd_escaped = escape_pattern(cwd)
			-- vim.notify("Full current file path is " .. file_path)
			-- vim.notify("Current working directory is " .. cwd)
			if not file_path:find("^" .. cwd_escaped) then
				error(file_path .. " is not within the current working directory: " .. cwd)
			end
			if not file_path:match("%.py$") then
				error(file_path .. " does not have a .py extension")
			end
			local relative_path = file_path:sub(#cwd + 2) -- +2 to remove both `/` and the cwd
			local module_path = relative_path:gsub("/", "."):gsub("%.py$", "")
			vim.notify("Debugging module " .. module_path, vim.log.levels.INFO)
			return module_path
		end

		-- returns a python interpreter path
		local function get_python_interpeter_path()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			else
				vim.notify("VIRTUAL_ENV not set. Using system Python.", vim.log.levels.WARN)
				return "/usr/bin/python3"
			end
		end

		-- configurations
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch current module",
				-- debugpy's python
				-- cwd = "/path/to/repository/root/dir",
				module = get_module_path,
				pythonPath = get_python_interpeter_path(),
			},
		}
	end,
}
