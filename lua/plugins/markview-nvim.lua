return {
  "OXY2DEV/markview.nvim",
  lazy = true, -- 非懒加载，确保随时可用
  dependencies = {
    { "nvim-treesitter/nvim-treesitter",lazy = false }, -- 语法解析增强
    "nvim-tree/nvim-web-devicons",     -- 文件图标支持
    "hrsh7th/nvim-cmp",                -- 补全支持（可选，用于代码块补全）
  },
  ft = { "markdown" }, -- 仅 Markdown 文件触发加载
  config = function()
    require("markview").setup({
      -- ===== 核心预览设置 =====
      preview = {
        enable = true,       -- 替代弃用的 initial_state，自动开启预览
        hybrid_modes = { "n", "i" }, -- 替代弃用的 hybrid_modes，在普通/插入模式启用混合预览
        width = 80,          -- 预览区宽度（字符数）
        position = "right",  -- 预览面板位置：left/right
        sync_scroll = true,  -- 源码与预览同步滚动
      },
      
      -- ===== 渲染增强 =====
      render = {
        code_highlight = { enable = true, theme = "monokai" }, -- 代码块高亮
        latex = { enable = true },   -- LaTeX 公式支持
        emoji = { enable = true },   -- :emoji: 短代码支持
        toc = {
          enable = true,     -- 自动生成目录
          position = "left", -- 目录位置：left/right/top/bottom
          depth = 4,         -- 标题层级深度
        },
        heading_anchors = true, -- 为标题添加锚点链接（兼容 Obsidian）
      },
      
      -- ===== 键盘映射 =====
      keymaps = {
        toggle = "<leader>md", -- 切换预览面板
      },
    })
  end
}
