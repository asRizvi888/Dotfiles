return {
  -- 1. FIX FOR SNACKS (Modern LazyVim default picker & explorer)
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- Applies globally to both finder search and the file explorer
        hidden = true,
        ignored = true,
        sources = {
          files = { hidden = true, ignored = true },
          explorer = { hidden = true, ignored = true },
        },
      },
    },
  },

  -- 2. FIX FOR TELESCOPE (Older/Alternative LazyVim fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = opts.defaults or {}
      -- Forces telescope to find dotfiles and gitignored items
      opts.defaults.vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--no-ignore",
      }
      opts.pickers = opts.pickers or {}
      opts.pickers.find_files = {
        hidden = true,
        no_ignore = true,
      }
    end,
  },

  -- 3. FIX FOR NEO-TREE (Older/Alternative LazyVim side file tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- Makes hidden files visible
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            -- ".env" -- Uncomment if a specific name is explicitly banned
          },
        },
      },
    },
  },
}
