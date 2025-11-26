return {
    "https://github.com/nvimdev/lspsaga.nvim",
    version = "*",
    cmd = "Lspsaga",
    opts = {
        finder = {
            keys = {
                toggle_or_open = "<CR>",
            },
        },
    },
    keys = {
        { "<F2>", ":Lspsaga rename<CR>" },--全局重命名变量
        { "<leader>lc", ":Lspsaga code_action<CR>" },--代码修复
        { "<leader>ld", ":Lspsaga definition<CR>" },--跳转到定义
        { "<leader>lh", ":Lspsaga hover_doc<CR>" },--查看文档说明
        { "<leader>lR", ":Lspsaga finder<CR>" },--查找引用和定义
        { "<leader>n", ":Lspsaga diagnostic_jump_next<CR>" },--跳转到下一个诊断
        { "<leader>p", ":Lspsaga diagnostic_jump_prev<CR>" },--跳转到上一个诊断
    }
}

