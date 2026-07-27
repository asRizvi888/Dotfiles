return {
  -- 1. Install the Solarized Osaka colorscheme plugin
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark", -- Force the dark variant
    },
  },

  -- 2. Tell LazyVim to use it as the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized-osaka",
    },
  },
}
