-- lua/lsp.lua
-- LSP 服务器配置 + jdtls 特殊处理
-- 注意：Neovim 0.11中直接使用vim.lsp API，不再依赖nvim-lspconfig
-- 使用一个简单的配置插件
return {
  -- 一个轻量级的配置占位符
  "echasnovski/mini.nvim",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- 创建基础 capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- 尝试加载 cmp_nvim_lsp，如果存在则使用
    local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    else
      -- 可选：开发时提示
      if vim.fn.getenv("NVIM") then
        vim.notify("cmp_nvim_lsp not found. Install it via lazy.nvim for better completion.", vim.log.levels.WARN)
      end
    end

    -- 通用 on_attach 回调
    local on_attach = function(client, bufnr)
      -- 禁用格式化，交由 null-ls 或专门的格式化工具处理
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- 可选：添加快捷键或其他逻辑
      -- require("lsp-format").on_attach(client)  -- 如果你用了格式化插件
    end

    -- LSP 服务器自定义配置
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "use", "describe", "it" }, -- 常见测试框架
            },
            workspace = {
              checkThirdParty = false, -- 避免第三方库类型检查干扰
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
      pyright = {
        -- 示例：自定义 Python 路径或虚拟环境
        -- settings = {
        --   python = {
        --     venvPath = ".venv",
        --     pythonPath = "./.venv/bin/python",
        --   },
        -- },
      },
      clangd = {},
      html = {},
      cssls = {},
      ts_ls = {},
      emmet_ls = {
        filetypes = { "html", "jsx", "tsx", "vue", "svelte" },
      },
    }

    -- 为Neovim 0.11创建简化的LSP配置
    -- 使用全局表存储配置信息
    _G.my_lsp_config = {
      capabilities = capabilities,
      on_attach = on_attach,
      servers = servers
    }
    
    -- 创建一个简单的函数来启动LSP服务器
    function _G.start_lsp_server(filetype)
      -- 映射文件类型到服务器名称
      local filetype_to_server = {
        lua = 'lua_ls',
        python = 'pyright',
        cpp = 'clangd',
        c = 'clangd',
        html = 'html',
        css = 'cssls',
        javascript = 'ts_ls',
        typescript = 'ts_ls',
        javascriptreact = 'ts_ls',
        typescriptreact = 'ts_ls',
        vue = 'emmet_ls',
        svelte = 'emmet_ls'
      }
      
      local server_name = filetype_to_server[filetype]
      if server_name and _G.my_lsp_config.servers[server_name] then
        -- 在Neovim 0.11中，我们使用vim.lsp.start_client而不是vim.lsp.config
        -- 这是一个更底层但更稳定的API
        local config = _G.my_lsp_config.servers[server_name]
        local client_config = {
          cmd = { server_name }, -- 假设服务器名称与可执行文件名称相同
          name = server_name,
          capabilities = _G.my_lsp_config.capabilities,
          on_attach = _G.my_lsp_config.on_attach
        }
        
        if config.settings then
          client_config.settings = config.settings
        end
        
        if config.filetypes then
          client_config.filetypes = config.filetypes
        end
        
        -- 尝试启动客户端，但使用pcall避免错误
        local ok, client_id = pcall(vim.lsp.start_client, client_config)
        if ok and client_id then
          vim.lsp.buf_attach_client(0, client_id)
        end
      end
    end
    
    -- 为常见文件类型创建自动命令
    local filetypes = {'lua', 'python', 'cpp', 'c', 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte'}
    for _, ft in ipairs(filetypes) do
      vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        callback = function()
          _G.start_lsp_server(ft)
        end
      })
    end

    -- Java 特殊处理：jdtls
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        -- 确保 jdtls 插件已加载
        if not pcall(require, "jdtls") then
          vim.notify("jdtls not found. Please install 'mfussenegger/nvim-jdtls'.", vim.log.levels.ERROR)
          return
        end

        local jdtls = require("jdtls")

        -- 项目根目录检测
        local root_dir = jdtls.setup.find_root({ ".git", "pom.xml", "build.gradle", "gradlew", "mvnw" })

        -- 可选：设置项目特定配置 - 适配 Neovim 0.11
        local config = {
          cmd = { "jdtls" }, -- 确保 jdtls 在 PATH 中，或写完整路径
          root_dir = root_dir,
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            on_attach(client, bufnr) -- 复用通用 on_attach

            -- Java 特有功能映射（可选）
            -- jdtls.setup.add_commands()
            -- vim.keymap.set("n", "<leader>co", jdtls.organize_imports, { buffer = bufnr })
            -- vim.keymap.set("n", "<leader>cr", jdtls.code_action, { buffer = bufnr })
          end,
        }

        -- 对于 jdtls，我们继续使用插件提供的方法，因为它有特殊处理
        jdtls.start_or_attach(config)
      end,
    })  
  end,
}

