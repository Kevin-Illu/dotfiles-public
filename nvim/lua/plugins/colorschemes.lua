return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme solarized-osaka]])
		end,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
}
