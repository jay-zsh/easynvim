return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    -- event = "VeryLazy",
    event = {"BufReadPost","BufNewFile"},
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "lua",
            "toml",
            "python",
            "java",
            "cpp",        -- C++
            "c",          -- C
            "json",
            "yaml",
            "bash",
            "markdown",
            "html",
            "css",
            "javascript",
            "typescript",
            "tsx",
            "go",
            "rust"
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
}

