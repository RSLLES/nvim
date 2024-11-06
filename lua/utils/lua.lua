local M = {}

-- Escape special characters in Lua patterns: ( ) . % + - * ? [ ^ $
function M.escape_pattern(text)
	return text:gsub("([%-%.%(%)%+%*%?%[%^%$])", "%%%1")
end

--- Returns true if the operating system is Windows.
function M.is_windows()
	return package.config:sub(1, 1) == "\\"
end

return M
