return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- higher priority than diagnostic info
        sign_priority = 20,
        -- sign style
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "▎" },
            topdelete = { text = "▔" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
    },
    keys = {
        { "]c", function() require("gitsigns").next_hunk() end, desc = "Git: Next hunk" },
        { "[c", function() require("gitsigns").prev_hunk() end, desc = "Git: Prev hunk" },
        { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Git: Stage hunk" },
        { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Git: Reset hunk" },
        { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Git: Preview hunk" },
        { "<leader>hd", function() require("gitsigns").diffthis() end, desc = "Git: Review buffer diff" },
        { "<leader>hb", function() require("gitsigns").blame_line() end, desc = "Git: Blame line" },
    },
}
