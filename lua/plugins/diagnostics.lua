-- lua/plugins/diagnostics.lua
return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      update_in_insert = true,
      signs = true,
      underline = true,
      severity_sort = true,
    })
  end,
}
