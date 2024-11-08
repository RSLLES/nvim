return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	events = "VeryLazy",
	config = function()
		local mason_nvim_dap = require("mason-nvim-dap")
		local python_utils = require("utils.python")

		-- tools
		local function get_debugpy_python_interpreter_path()
			local python_path = vim.fs.joinpath(
				vim.fn.stdpath("data"),
				"mason",
				"packages",
				"debugpy",
				python_utils.get_venv_python_path({ venv_name = "venv" })
			)
			-- launch pythonw instead of python, which does not spawn a shell with windows
			python_path = python_path .. "w"
			vim.notify("Debugpy path is " .. python_path)
			return python_path
		end

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

		-- setup
		mason_nvim_dap.setup({
			ensure_installed = {
				"codelldb", -- c++
				"python", -- debugpy
			},
			handlers = {
				-- default handler
				function(config)
					config.adapters.options = { initialize_timeout_sec = 12 }
					mason_nvim_dap.default_setup(config)
				end,

				-- python
				python = function(config)
					-- configurations
					config.configurations = {
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
						{
							type = "python",
							request = "launch",
							name = "Current file (justMyCode = true)",
							program = "${file}",
							pythonPath = get_python_interpeter_path,
							console = "integratedTerminal",
							justMyCode = true,
						},
					}

					-- adapters
					config.adapters = function(cb, config)
						if config.request == "attach" then
							error("Dunno what this section is doing so I put an error here so you know it is useful")
							local port = (config.connect or config).port
							local host = (config.connect or config).host or "127.0.0.1"
							cb({
								type = "server",
								port = assert(port, "`connect.port` is required for a python `attach` configuration"),
								host = host,
								options = {
									source_filetype = "python",
								},
							})
						else
							cb({
								type = "executable",
								command = get_debugpy_python_interpreter_path(),
								args = { "-m", "debugpy.adapter" },
								options = {
									source_filetype = "python",
									initialize_timeout_sec = 12,
								},
							})
						end
					end

					mason_nvim_dap.default_setup(config)
				end,
			},
		})
	end,
}
