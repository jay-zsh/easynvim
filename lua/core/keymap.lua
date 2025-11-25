-- 告诉 Lua 语言服务器 vim 是全局变量
---@diagnostic disable: undefined-global

-- <Ctrl-z> 绑定为撤销 (undo)
vim.keymap.set({"n","i"}, "<C-z>", "<Cmd>undo<CR>", { silent = true })

-- Insert 模式下：jj = Esc
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Leader 键设置
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Normal 模式下：<C-t> 打开终端（底部分屏）
vim.keymap.set("n", "<C-t>", ":botright 8split | terminal<CR>", { noremap = true, silent = true })

-- Terminal 模式下：jj 切换到 Normal 模式
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Terminal 模式下：Esc 切换到 Normal 模式
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Normal 模式下：<C-s> 保存文件
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Insert 模式下：<C-s> 保存文件（退出插入 → 保存 → 回到插入）
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- 自定义翻页：tt = PageUp, bb = PageDown
vim.keymap.set("n", "tt", "<C-b>", { noremap = true, silent = true })
vim.keymap.set("n", "bb", "<C-f>", { noremap = true, silent = true })
vim.keymap.set("i", "tt", "<Esc><C-b>", { noremap = true, silent = true })
vim.keymap.set("i", "bb", "<Esc><C-f>", { noremap = true, silent = true })
