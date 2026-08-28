return {
  "shaunsingh/nord.nvim",
  name = "nord",
  priority = 1000,

  config = function()
    require("nord").set()
    vim.cmd[[colorscheme nord]]
  end
}
