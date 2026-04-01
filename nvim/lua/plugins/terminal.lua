return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			autochdir = true,
			tab_size = 18,
		})

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			-- Salir a modo normal de terminal (Scrollback)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

			vim.keymap.set("t", "sh", [[<C-\><C-n><C-w>h]], opts)
			vim.keymap.set("t", "sj", [[<C-\><C-n><C-w>j]], opts)
			vim.keymap.set("t", "sk", [[<C-\><C-n><C-w>k]], opts)
			vim.keymap.set("t", "sl", [[<C-\><C-n><C-w>l]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
