return {
	"zaldih/themery.nvim",
	dependencies = {
		"neanias/everforest-nvim",
		"rebelot/kanagawa.nvim",
		"sho-87/kanagawa-paper.nvim",
		"gbprod/nord.nvim",
	},
	lazy = false,
	config = function()
		require("themery").setup({
			themes = {
				{
					name = "everforest_dark",
					colorscheme = "everforest",
					before = [[ vim.opt.background = "dark" ]],
				},
				{
					name = "everforest_light",
					colorscheme = "everforest",
					before = [[ vim.opt.background = "light" ]],
				},
				{
					name = "kanagawa_light",
					colorscheme = "kanagawa",
					before = [[ vim.opt.background = "light" ]],
				},
				{
					name = "kanagawa-paper",
					colorscheme = "kanagawa-paper",
				},
				{
					name = "nord",
					colorscheme = "nord",
				},
			},
			livePreview = true,
		})

		vim.keymap.set("n", "<leader>ts", "<cmd>Themery<CR>", { desc = "Pick a theme" })

		-- custom configs
		require("everforest").setup({ background = "soft" })
	end,
}
