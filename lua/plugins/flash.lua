return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            -- keep '/' behaviour unchange
            search = { enabled = false }, 
            -- keep 'tTfT' behaviour unchange
            char = { enabled = false },
        },
    },
    config = function(_, opts)
        require("flash").setup(opts)
        -- better theme
        vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#1E1E1E", bg = "#FFC66D", bold = true })
        vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#FFB86C", bold = true })
        vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#2D2D2D", fg = "#FFB86C" })
        vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#4A4A4A" })
    end,
    keys = {
        -- o-mode is safe: nvim-surround's ys/ds/cs are normal-mode multi-key maps,
        -- vim resolves them BEFORE entering operator-pending, so flash only handles
        -- other operators (>, <, =, gu, ...) — jump-as-motion stays available
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
        -- no S mapping: visual S belongs to nvim-surround (surround selection)
    },
}
