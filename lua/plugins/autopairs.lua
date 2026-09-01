return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")

        npairs.setup({
            -- Treesitter smart assessment
            check_ts = true,
            ts_config = {
                rust = { "string", "comment" },
            },

            -- skip right symbol
            enable_moveright = true,

            -- delete pair
            enable_afterquote = true,
            map_bs = true,

            -- FastWrap
            fast_wrap = {
                map = "<A-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = [=[[%'%"%]%}%)%s]=],
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "Search",
                highlight_grey = "Comment",
            },
        })

        -- nvim-cmp adapt
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if cmp_status_ok then
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}
