# Neovim 配置文件

这是一个基于 Neovim 0.12(beat) 的现代化配置，使用 Lua 语言编写，提供了完整的代码补全、语法高亮、LSP 支持、文件浏览和模糊搜索等功能，内有python，css,html,js,ts,c++等基本lsp。启动速度中等122ms左右较为流畅。

## 功能特色

- 🎨 现代化 UI，使用 TokyoNight 主题
- 💻 完整的 LSP 配置，适配 Neovim 0.12 新 API
- 📝 智能代码补全系统
- 🔍 强大的模糊搜索功能（Telescope）
- 📁 美观的文件浏览器（Nvim-Tree）
- 🌳 高级语法高亮（Tree-sitter）
- 🧰 包管理器集成（Mason）
- ⌨️ 便捷的快捷键配置

## 安装要求

- Neovim 0.12 或更高版本,0.11似乎也可以但是，有些可能已经更改。
- Git
- Node.js 和 npm (用于部分 LSP 服务器)
- Python 3 (用于部分 LSP 服务器)
- CMake (用于构建 telescope-fzf-native)

## 安装方法

1. 备份您现有的 Neovim 配置（如果有）：
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup  # Linux/Mac
   # 或在 Windows 上
   # move %LOCALAPPDATA%\nvim %LOCALAPPDATA%\nvim.backup
   ```

2. 克隆此配置：
   ```bash
   git clone git@github.com:jay-zsh/easynvim.git ~/.config/nvim  # Linux/Mac
   # 或在 Windows 上
   # git clone git@github.com:jay-zsh/easynvim.git %LOCALAPPDATA%\nvim
   ```

3. 首次启动 Neovim：
   ```bash
   nvim
   ```
   此时会自动安装 lazy.nvim 插件管理器和所有配置的插件。

4. 安装 LSP 服务器：
   ```bash
   nvim
   :Mason
   ```
   然后在 Mason 界面中安装您需要的语言服务器。

## 目录结构

```
lua/
├── core/              # 核心配置
│   ├── basic.lua      # 基础设置
│   ├── keymap.lua     # 快捷键配置
│   └── lazy.lua       # 插件管理器配置
└── plugins/           # 插件配置
    ├── cmp.lua        # 代码补全
    ├── lsp.lua        # LSP 配置
    ├── mason.lua      # Mason 包管理器
    ├── lualine.lua    # 状态栏
    ├── nvim-tree.lua  # 文件浏览器
    ├── telescope.lua  # 模糊搜索
    ├── tokyonight.lua # 主题
    └── ...            # 其他插件

```
# 🌟 Neovim 配置目录结构说明

## 📁 lua/
Neovim 的核心配置目录，包含各类插件与功能模块的 Lua 文件。

### 📄 blink.lua
- 控制光标闪烁行为，增强视觉反馈。

### 📄 bufferline.lua
- 美化并管理顶部 buffer 标签栏，支持图标与状态显示。

### 📄 cmp.lua
- 配置自动补全插件 nvim-cmp，集成 LSP、路径、词典等补全源。
- 快捷键：上一个<Ctrl-p>，下一个<Ctrl-n>,<Tab>

### 📄 diagnostics.lua
- 设置诊断信息显示方式，如错误提示、警告图标等。

### 📄 grug-far.lua
- 提供跨文件模糊查找与替换功能，适合批量修改。
- 快捷键：<空格-fg>

### 📄 hop.lua
- 快速跳转插件配置，支持按字符、词或行跳转。
- 快捷键：<ff>

### 📄 indent-blankline.lua
- 显示缩进参考线，提升代码层级可读性。

### 📄 lsp.lua
- 核心 LSP 客户端配置，定义语言服务器行为与能力。

### 📄 lspsaga.lua
- 增强 LSP UI 体验，如代码跳转、悬浮窗口、符号预览等。
- 快捷键：
    - 错误诊断：上一个<空格+p>,下一个<空格+n>
    - 全局变量重命名：<F2> 

### 📄 lualine.lua
- 状态栏美化插件配置，支持图标、Git 状态、诊断信息等。

### 📄 markview-nvim.lua
- Markdown 文件预览插件配置，支持实时渲染与导航。

### 📄 mason.lua
- 管理 LSP、DAP、格式化器等工具的安装与更新。

### 📄 none-ls.lua
- 配置 null-ls，用于集成非 LSP 格式化器与诊断工具。
-快捷键：<空格-lf>

### 📄 nvim-autopairs.lua
- 自动补全括号、引号等成对符号，提升输入效率。

### 📄 nvim-surround.lua
- 快捷修改包裹符号，如括号、引号等，支持多种操作模式。

### 📄 nvim-tree.lua
- 文件树插件配置，提供侧边栏文件浏览与操作功能。
- 快捷键：<空格-u>

### 📄 nvim-treesitter.lua
- 配置语法解析器 Treesitter，增强代码高亮与结构识别。

### 📄 telescope.lua
- 模糊查找插件配置，支持文件、buffer、Git、LSP 等多种搜索源。
- 快捷键：<空格-fr>

### 📄 toggleterm.lua
- 内嵌终端配置，支持多窗口、浮动、横竖分屏等模式。
- 快捷键：<Ctrl-t>

### 📄 tokyonight.lua
- 配置主题色彩方案，使用 Tokyo Night 风格。


## 基础设置

### 编辑器行为

- 显示行号和相对行号
- 光标所在行高亮
- 80 字符处显示高亮线
- Tab 转换为 4 个空格
- 自动加载外部修改的文件
- 分屏默认在下方和右方
- 查找时忽略大小写（但保留智能大小写功能）
- 关闭底部模式提示

### 快捷键

#### 通用快捷键

- `<Space>` 作为 Leader 键
- `<Ctrl-z>` 撤销（等价于 `<u>`）
- `jj` 在插入模式下退出到普通模式（替代 `<Esc>`）
- `<Ctrl-s>` 保存文件（在普通模式和插入模式下都有效）

#### 插件快捷键

- `<Leader>ff` - 使用 Telescope 查找文件
- `<Leader>fg` - 使用 Telescope 进行文本搜索
- `<Leader>uf` - 切换 NvimTree 文件浏览器

## 常用插件详细说明

### 1. 代码补全（nvim-cmp）

提供智能代码补全功能，支持 LSP、代码片段、缓冲区和路径补全。

- 主要来源：LSP、LuaSnip、缓冲区、路径
- 补全项带有图标和类型指示
- 使用 `<Tab>` 和 `<S-Tab>` 在补全项间导航
- `<Ctrl-p/n>` 手动触发补全

### 2. LSP 配置

专为 Neovim 0.12 设计的 LSP 配置，不再依赖于 nvim-lspconfig 插件，而是直接使用 Neovim 内置的 LSP API。

支持的语言服务器：
- lua_ls（Lua）
- pyright（Python）
- clangd（C/C++）
- html（HTML）
- cssls（CSS）
- ts_ls（JavaScript/TypeScript）
- emmet_ls（HTML 快速编辑）

每个文件类型会自动启动对应的 LSP 服务器。

### 3. 包管理器（Mason）

用于管理 LSP 服务器、DAP 服务器、linters 和格式化工具。

- 自动安装配置的 LSP 服务器
- 提供可视化界面管理已安装的包
- 命令：`:Mason`, `:MasonInstall`, `:MasonUpdate`

### 4. 文件浏览器（Nvim-Tree）

提供侧边栏文件浏览器功能。

- `<Leader>u` 切换文件浏览器
- 打开文件时自动关闭文件浏览器

### 5. 模糊搜索（Telescope）

强大的模糊搜索工具。

- `<Leader>ff` - 查找文件
- `<Leader>fg` - 全文搜索
- 集成了 fzf 算法，提供更快的搜索体验

### 6. 语法高亮（nvim-treesitter）

提供高级语法高亮和代码解析功能。

- 支持多种编程语言
- 禁用了额外的 Vim 正则表达式高亮以提高性能

### 7. 状态栏（lualine）

美观的状态栏，显示文件名、分支、差异、文件大小、编码和文件类型等信息。

### 8. 主题（tokyonight）

现代化的暗黑主题，使用 moon 变体。

## 自定义配置

### 添加新插件

在 `lua/plugins/` 目录下创建新文件，使用 lazy.nvim 的配置格式：

```lua
return {
  "插件作者/插件名称",
  event = "SomeEvent",  -- 触发条件
  config = function()
    -- 插件配置
  end,
}
```

### 修改 LSP 服务器

编辑 `lua/plugins/lsp.lua` 文件，在 `servers` 表中添加或修改服务器配置：

```lua
local servers = {
  -- 添加新服务器
  new_server = {
    settings = {
      -- 服务器特定设置
    },
  },
}
```

同时需要在 `filetype_to_server` 映射中添加对应的文件类型映射。

### 修改快捷键

编辑 `lua/core/keymap.lua` 文件，使用 `vim.keymap.set()` 添加新的快捷键。

## 兼容性说明

此配置专为 Neovim 0.12 设计，利用了其新的 LSP API，不再依赖于已弃用的 nvim-lspconfig 插件。如果您使用的是较旧版本的 Neovim，可能需要调整 LSP 相关配置。

## 故障排除

### LSP 服务器无法启动

1. 确保已通过 Mason 安装了对应的 LSP 服务器
2. 检查 LSP 服务器是否在 PATH 中
3. 查看 `:LspInfo` 获取详细的 LSP 状态信息

### 插件安装失败

1. 确保网络连接正常
2. 检查是否安装了所需的依赖（如 Node.js、Python 等）
3. 尝试运行 `:Lazy clean` 和 `:Lazy sync`

## 许可证

[MIT](LICENSE)
