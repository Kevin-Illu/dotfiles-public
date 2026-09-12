-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Fuerza a que CUALQUIER terminal (ToggleTerm o nativa) use tus saltos 's'
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("TerminalNavigation", { clear = true }),
	pattern = "term://*",
	callback = function()
		local opts = { buffer = 0 }
		-- Salir a modo normal (Scrollback)
		vim.keymap.set("n", "jk", [[<C-\><C-n>]], opts)

		-- Saltos directos 's' desde la terminal
		-- Agregamos <C-\><C-n> al inicio para asegurar que Neovim cambie el foco
		vim.keymap.set("n", "sh", [[<C-\><C-n><C-w>h]], opts)
		vim.keymap.set("n", "sj", [[<C-\><C-n><C-w>j]], opts)
		vim.keymap.set("n", "sk", [[<C-\><C-n><C-w>k]], opts)
		vim.keymap.set("n", "sl", [[<C-\><C-n><C-w>l]], opts)
	end,
})
