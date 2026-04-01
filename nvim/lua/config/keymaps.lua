local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- quit neovim saving the current file and without
keymap.set("n", "wq", ":wq<CR>")
keymap.set("n", "qq", ":q!<CR>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<CR>", opts)
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)

-- Split window
keymap.set("n", "ss", ":split<CR>", opts)
keymap.set("n", "sv", ":vsplit<CR>", opts)
-- En tu archivo de keymaps.lua
-- Rotar ventanas (The Unix Way: reordenar el layout sin cerrar nada)
keymap.set("n", "<Leader>rh", "<C-w>H") -- Mueve ventana actual a la izquierda (ocupa todo el alto)
keymap.set("n", "<Leader>rk", "<C-w>K") -- Mueve ventana actual arriba (ocupa todo el ancho)
keymap.set("n", "<Leader>rj", "<C-w>J") -- Mueve ventana actual abajo (ocupa todo el ancho)
keymap.set("n", "<Leader>rl", "<C-w>L") -- Mueve ventana actual a la derecha (ocupa todo el alto)

-- Maximizar split actual (Toggle de zoom para enfocarte en el código o la terminal)
keymap.set("n", "<Leader><", ":vertical resize | resize<CR>", opts)
keymap.set("n", "<Leader>>", "<C-w>=", opts) -- Restaurar todos los tamaños

-- Move window
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sl", "<C-w>l", opts)

-- Resize window (Usando Alt + Flechas)
keymap.set("n", "<A-left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<A-right>", ":vertical resize +2<CR>", opts)
keymap.set("n", "<A-up>", ":resize +2<CR>", opts)
keymap.set("n", "<A-down>", ":resize -2<CR>", opts)

-- Opcional: Usar Alt + hjkl para no mover las manos del home row
keymap.set("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<A-j>", ":resize -2<CR>", opts)
keymap.set("n", "<A-k>", ":resize +2<CR>", opts)
keymap.set("n", "<A-l>", ":vertical resize +2<CR>", opts)

--Diagnostics Navigation (Standard & Fast)
-- ]d -> Siguiente error/warning
-- [d -> Anterior error/warning
keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, opts)

keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, opts)

keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float()
end, opts)

keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist()
end, opts)
