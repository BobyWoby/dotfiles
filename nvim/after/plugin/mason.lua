require("mason").setup()
require("nvim-dap-virtual-text").setup({
    event="VeryLazy",
  ensure_installed = {
    "codelldb"
  },
  automatic_installation = true
})
