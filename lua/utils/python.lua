local M = {}

local lua_utils = require("utils.lua")
local os_utils = require("utils.os")

function get_python_interpeter_path_windows()
	local output = vim.fn.system("where python")
	local first_match = output:match("^[^\r\n]+")
	return first_match
end

function get_python_interpeter_path_unix()
	return vim.fn.system("which python"):gsub("%s+", "") -- Trim whitespace
end

-- returns a python interpreter path
function M.get_python_interpeter_path()
	local system_python = os_utils.is_windows() and get_python_interpeter_path_windows()
		or get_python_interpeter_path_unix()
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
	if not file_path:find("^" .. cwd_escaped) then
		error(file_path .. " is not within the current working directory: " .. cwd)
	end
	if not file_path:match("%.py$") then
		error(file_path .. " does not have a .py extension")
	end
	local relative_path = file_path:sub(#cwd + 2) -- +2 to remove both separator and the cwd
	local path_sep = os_utils.is_windows() and "\\" or "/"
	local module_path = relative_path:gsub(path_sep, "."):gsub("%.py$", "")
	return module_path
end

return M
