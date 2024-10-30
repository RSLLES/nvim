vim.diagnostic.config({
	virtual_text = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
})

vim.keymap.set(
	"n",
	"<leader>ge",
	vim.diagnostic.open_float,
	{ desc = "Expand linter information in a floating window" }
)
