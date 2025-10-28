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
        { "<leader>lr", ":Lspsaga rename<CR>" },
        { "<leader>lc", ":Lspsaga code_action<CR>" },
        { "<leader>ld", ":Lspsaga definition<CR>" },
        { "<leader>lh", ":Lspsaga hover_doc<CR>" },
        { "<leader>lR", ":Lspsaga finder<CR>" },
        { "<leader>ln", ":Lspsaga diagnostic_jump_next<CR>" },
        { "<leader>lp", ":Lspsaga diagnostic_jump_prev<CR>" },
    }
}


