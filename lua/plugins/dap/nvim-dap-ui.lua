return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	events = "VeryLazy",
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup({
			controls = { enabled = false },
		})
		-- open-close nvim-dap-ui with dap
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- keymaps
		local km = vim.keymap -- for conciseness

		km.set("n", "<leader>dt", function()
			dapui.toggle()
		end, { desc = "Toggle ui" })

		km.set("n", "<leader>dy", function()
			dapui.open({ reset = true })
		end, { desc = "Reset and open ui if needed" })
	end,
}
