return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	events = "VeryLazy",
	config = function()
		local mason_nvim_dap = require("mason-nvim-dap")

		mason_nvim_dap.setup({
			ensure_installed = {
				"codelldb", -- c++
				"python", -- install debugpy for python
			},
			handlers = {
				-- default handler
				function(config)
					config.adapters.options = { initialize_timeout_sec = 12 }
					mason_nvim_dap.default_setup(config)
				end,
			},
		})
	end,
}
