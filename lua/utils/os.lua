local M = {}

--- Returns true if the operating system is Windows.
function M.is_windows()
	return package.config:sub(1, 1) == "\\"
end

return M
