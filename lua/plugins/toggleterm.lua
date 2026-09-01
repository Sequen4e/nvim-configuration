return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<leader>th", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    },
    config = function()
        require("toggleterm").setup({
            size = 15,
            direction = "horizontal",
            shade_terminals = true,
            persist_size = true,
            close_on_exit = true,
        })

        -- **Terminal Mode** key binding
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            -- Esc Esc: back to normal mode
            vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)
            -- fast focus to code window
            vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        end

        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = function()
                set_terminal_keymaps()
            end,
        })
    end,
}
