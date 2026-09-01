return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    -- basic style
    indent = {
      char = "┊", -- optional styles: "│", "┆", "┊", "┊"
      tab_char = "┊",
    },

    -- scope/pair symbol highlight
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
      injected_languages = false,
      highlight = { "Function", "Label" }, -- active highlight group
      priority = 1024,
      char = "│", -- current style
    },

    -- ignoring none src files
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        -- text files
        "text",
        "markdown",
        "tex",
      },
    },
  },
}
