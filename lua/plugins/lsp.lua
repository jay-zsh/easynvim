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
      vim.notify("cmp_nvim_lsp not found. Install it via lazy.nvim for better completion.", vim.log.levels.WARN)
    end

    -- 确保支持代码片段（对HTML/Emmet很重要）
    capabilities.textDocument.completion.completionItem.snippetSupport = true

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
        cmd = { "lua-language-server" },
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
        cmd = { "pyright-langserver", "--stdio" },
      },
      clangd = {
        cmd = { "clangd" },
      },
      html = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" }
      },
      cssls = {
        cmd = { "vscode-css-language-server", "--stdio" },
      },
      tsserver = {
        cmd = { "typescript-language-server", "--stdio" },
      },
      emmet_ls = {
        cmd = { "emmet-ls", "--stdio" },
        filetypes = { "html", "jsx", "tsx", "vue", "svelte" },
      },
    }

    -- 为Neovim 0.11创建简化的LSP配置
    _G.my_lsp_config = {
      capabilities = capabilities,
      on_attach = on_attach,
      servers = servers
    }
    
    -- 美化通知的函数
    local function notify_success(message)
      vim.notify("✅ " .. message, vim.log.levels.INFO, {
        title = "LSP 状态",
        icon = "",
      })
    end
    
    local function notify_warning(message)
      vim.notify("⚠️ " .. message, vim.log.levels.WARN, {
        title = "LSP 警告",
        icon = "",
      })
    end
    
    local function notify_error(message)
      vim.notify("❌ " .. message, vim.log.levels.ERROR, {
        title = "LSP 错误",
        icon = "",
      })
    end
    
    local function notify_info(message)
      vim.notify("ℹ️ " .. message, vim.log.levels.INFO, {
        title = "LSP 信息",
        icon = "",
      })
    end
    
    -- 修正版函数：启动LSP服务器并显示美化状态通知
    function _G.start_lsp_server(filetype)
      -- 映射文件类型到服务器名称
      local filetype_to_server = {
        lua = 'lua_ls',
        python = 'pyright',
        cpp = 'clangd',
        c = 'clangd',
        html = 'html',
        css = 'cssls',
        javascript = 'tsserver',
        typescript = 'tsserver',
        javascriptreact = 'tsserver',
        typescriptreact = 'tsserver',
        vue = 'emmet_ls',
        svelte = 'emmet_ls'
      }
      
      local server_name = filetype_to_server[filetype]
      if not server_name then
        notify_info(string.format("文件类型 '%s' 未配置LSP服务器", filetype))
        return
      end
      
      if not _G.my_lsp_config.servers[server_name] then
        notify_warning(string.format("LSP服务器 '%s' 未在配置中定义", server_name))
        return
      end

      -- 检查服务器是否已启动
      local active_clients = vim.lsp.get_clients()
      for _, client in ipairs(active_clients) do
        if client.name == server_name then
          notify_info(string.format("LSP服务器 '%s' 已在运行", server_name))
          return
        end
      end

      -- 显示启动进度
      notify_info(string.format("正在启动 %s 服务器...", server_name))
      
      local config = _G.my_lsp_config.servers[server_name]
      
      local client_config = {
        name = server_name,
        cmd = config.cmd,
        filetypes = config.filetypes or { filetype },
        root_dir = vim.fn.getcwd(),
        capabilities = _G.my_lsp_config.capabilities,
        on_attach = _G.my_lsp_config.on_attach,
        settings = config.settings or {}
      }
      
      -- 使用vim.lsp.start API
      local ok, client_id = pcall(function()
        return vim.lsp.start(client_config)
      end)
      
      if ok and client_id then
        notify_success(string.format("%s 服务器启动成功", server_name))
      else
        local error_msg = client_id or "未知错误"
        
        -- 提供更具体的错误建议
        local suggestion = ""
        if string.find(error_msg:lower(), "cmd", 1, true) or 
           string.find(error_msg:lower(), "spawn", 1, true) or
           string.find(error_msg:lower(), "executable", 1, true) then
          suggestion = "\n💡 请确保已安装对应的LSP服务器并在PATH中可用"
        elseif string.find(error_msg:lower(), "timeout", 1, true) then
          suggestion = "\n💡 启动超时，请检查网络连接或服务器配置"
        end
        
        notify_error(string.format("%s 服务器启动失败\n%s%s", server_name, error_msg, suggestion))
      end
    end
    
    -- 为常见文件类型创建自动命令
    local filetypes = {'lua', 'python', 'cpp', 'c', 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte'}
    
    for _, ft in ipairs(filetypes) do
      vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        callback = function(args)
          vim.schedule(function()
            local buf_ft = vim.bo[args.buf].filetype
            if buf_ft == ft then
              notify_info(string.format("检测到 %s 文件，正在配置LSP...", ft))
              _G.start_lsp_server(ft)
            end
          end)
        end
      })
    end

    -- Java 特殊处理：jdtls
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function(args)
        vim.schedule(function()
          local buf_ft = vim.bo[args.buf].filetype
          if buf_ft ~= "java" then return end
          
          notify_info("检测到 Java 文件，正在启动 jdtls...")
          
          -- 确保 jdtls 插件已加载
          if not pcall(require, "jdtls") then
            notify_error("jdtls 插件未找到，请安装 'mfussenegger/nvim-jdtls'")
            return
          end

          local jdtls = require("jdtls")

          -- 项目根目录检测
          local root_dir = jdtls.setup.find_root({ ".git", "pom.xml", "build.gradle", "gradlew", "mvnw" })
          
          if not root_dir then
            notify_warning("未找到 Java 项目根目录，jdtls 可能无法正常工作")
            root_dir = vim.fn.getcwd()
          end

          local config = {
            cmd = { "jdtls" },
            root_dir = root_dir,
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              on_attach(client, bufnr)
              notify_success("jdtls 服务器附加成功")
            end,
          }

          local ok, err = pcall(jdtls.start_or_attach, config)
          if ok then
            notify_success("jdtls 启动成功")
          else
            notify_error("jdtls 启动失败: " .. tostring(err))
          end
        end)
      end,
    })
    
    -- 添加手动启动LSP的命令，用于调试
    vim.api.nvim_create_user_command('StartLSP', function(opts)
      local ft = opts.args or vim.bo.filetype
      if ft == '' then
        notify_error("请指定文件类型或在当前缓冲区中使用")
        return
      end
      _G.start_lsp_server(ft)
    end, { nargs = '?', complete = function() return filetypes end })
    
    -- 初始化完成提示
    vim.schedule(function()
      notify_success("LSP 配置加载完成")
    end)
  end,
}
