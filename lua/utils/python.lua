local M = {}

local lua_utils = require("utils.lua")

-- returns a python interpreter path
function M.get_python_interpeter_path()
	local system_python = vim.fn.system("which python"):gsub("%s+", "") -- Trim whitespace
	if system_python == "" then
		error("No Python interpreter found. Please ensure Python is installed and in your PATH.")
	end
	return system_python
end

-- returns the path of the current file formated as a python module path
function M.get_module_path()
	local file_path = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()
	local cwd_escaped = lua_utils.escape_pattern(cwd)
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
	return module_path
end

return M
