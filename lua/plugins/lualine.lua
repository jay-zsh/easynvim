return {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter", -- 界面渲染完成后触发
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    --event = "VeryLazy",
    opts = {
        options = {
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
        extensions = { "nvim-tree" },
        sections = {
            lualine_b = { "branch", "diff" },
            lualine_x = {
                "filesize",
                "encoding",
                "filetype",
            },
        },
    },
}

