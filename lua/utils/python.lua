local M = {}

local lua_utils = require("utils.lua")
local os_utils = require("utils.os")

-- returns the relative path to the Python interpreter in a virtual environment.
-- @param args table Optional; contains venv_name, default is ".venv".
function M.get_venv_python_path(args)
	local venv_name = args and args.venv_name or ".venv"
	local path_sep = os_utils.is_windows() and "\\" or "/"
	return venv_name .. path_sep .. (os_utils.is_windows() and "Scripts" or "bin") .. path_sep .. "python"
end

-- returns a python interpreter path
function M.get_python_interpeter_path()
	local system_python = ""
	if os_utils.is_windows() then
		local output = vim.fn.system("where python")
		system_python = output:match("^[^\r\n]+") -- first match
	else
		local output = vim.fn.system("which python")
		system_python = output:gsub("%s+", "") -- Trim whitespace
	end
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
