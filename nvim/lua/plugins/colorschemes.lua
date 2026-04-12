-- return {
-- 	{
-- 		"craftzdog/solarized-osaka.nvim",
-- 		lazy = false,
-- 		priority = 1000,
-- 		opts = function()
-- 			return {
-- 				transparent = false,
-- 			}
-- 		end,
-- 		config = function()
-- 			vim.cmd([[colorscheme solarized-osaka]])
-- 		end,
-- 	},
-- }
--
return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		-- Al quitar 'config', lazy hace el setup(opts) por ti
		opts = {
			transparent = false,
			styles = {
				sidebars = "dark",
				floats = "dark",
			},
		},
		config = function(_, opts)
			require("solarized-osaka").setup(opts)
			vim.cmd([[colorscheme solarized-osaka]])
		end,
	},
}
