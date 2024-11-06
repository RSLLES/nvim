local M = {}

-- Escape special characters in Lua patterns: ( ) . % + - * ? [ ^ $
function M.escape_pattern(text)
	return text:gsub("([%-%.%(%)%+%*%?%[%^%$])", "%%%1")
end

return M
