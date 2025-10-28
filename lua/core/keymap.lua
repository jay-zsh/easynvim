--<Ctrl-z>绑定u
-- 告诉Lua语言服务器vim是全局变量
---@diagnostic disable: undefined-global
vim.keymap.set({"n","i"},"<C-z>","<Cmd>undo<CR>", {silent = true})


--<jj> 绑定Esc
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = ","

--调出终端
--vim.keymap.set('n', '<C-t>', ':botright 8split | terminal<CR>', { noremap = true, silent = true })


-- 在终端模式中按 jj 切换到 normal 模式
--vim.keymap.set('t', 'jj', [[<C-\><C-n>]], { noremap = true, silent = true })

-- 在终端模式中按 Esc 切换到 normal 模式
--vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Normal 模式下：<C-s> 保存文件
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Insert 模式下：先退出 insert，再保存，再回到 insert
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })




