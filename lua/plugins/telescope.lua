return {
    "https://github.com/nvim-telescope/telescope.nvim",
    cmd = "Telescope",  -- cmd Telescope` 懒加载
    dependencies = {
        "https://github.com/nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files (Telescope)" },
        { "<leader>fg", function() 
            -- 检查ripgrep是否可用
            local has_rg = false
            if vim.fn.executable('rg') == 1 or vim.fn.executable('ripgrep') == 1 then
                has_rg = true
            end
            
            if has_rg then
                -- ripgrep可用，使用live_grep
                vim.cmd('Telescope live_grep')
            else
                -- ripgrep不可用，使用普通的find_files替代
                vim.notify("ripgrep未安装，使用文件查找替代。推荐安装ripgrep以获得更好的搜索体验。", vim.log.levels.WARN)
                vim.cmd('Telescope find_files')
            end
        end, desc = "Live Grep (Safe)" },
    },
    opts = {
        defaults = {
            sorting_strategy = "ascending",
            layout_config = {
                prompt_position = "top",
            },
            -- 移除不正确的sorter配置，使用默认值
        },
    },
    config = function(_, opts)
        local telescope = require "telescope"
        telescope.setup(opts)
    end,
}
