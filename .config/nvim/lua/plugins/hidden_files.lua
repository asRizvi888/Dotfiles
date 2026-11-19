-- Explorer shows everything (dotfolders, gitignored); search shows dotfiles like
-- .gitignore and .env.* but skips build/dependency folders.
local search_exclude = {
  ".git",
  "node_modules",
  ".next",
  ".nuxt",
  ".turbo",
  ".vercel",
  ".open-next",
  ".wrangler",
  ".svelte-kit",
  ".output",
  ".astro",
  ".expo",
  ".parcel-cache",
  ".angular",
  ".gradle",
  ".idea",
  ".pytest_cache",
  ".mypy_cache",
  ".ruff_cache",
  ".cache",
  ".venv",
  "__pycache__",
  "build",
  "dist",
  "out",
  "coverage",
  "target",
}

local search = { hidden = true, ignored = true, exclude = search_exclude }

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = { hidden = true, ignored = true },
          files = search,
          grep = search,
          grep_word = search,
          grep_buffers = search,
        },
      },
    },
  },
}
