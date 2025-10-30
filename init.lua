-- 设置包路径，确保能正确加载 lua 模块
package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '/lua/?.lua'

-- 加载核心配置
require('core.basic')
require('core.keymap')

-- 加载插件管理器
require('core.lazy')

