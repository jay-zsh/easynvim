return{
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    opts = {
        options = {
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
                local indicator = " "
                for level, number in pairs(diagnostics_dict) do
                    local symbol
                    if level == "error" then
                        symbol = " "
                    elseif level == "warning" then
                        symbol = " "
                    else
                        symbol = " "
                    end
                    indicator = indicator .. number .. symbol
                end
                return indicator
            end,
            offsets = {}
        }
    },

    keys = {
        { "<leader>bh", ":BufferLineCyclePrev<CR>",   silent = true }, -- 空格+h 向左切换标签
        { "<leader>bl", ":BufferLineCycleNext<CR>",   silent = true }, -- 空格+l 向右切换标签
        { "<leader>bp", ":BufferLinePickClose<CR>",   silent = true }, -- 空格+p 选择关闭标签
        { "<leader>bc", ":BufferLineCloseOthers<CR>", silent = true }, -- 空格+c 关闭其他标签
        { "<leader>bd", ":bdelete<CR>",               silent = true }, -- 空格+d 删除当前缓冲区
    },
}





