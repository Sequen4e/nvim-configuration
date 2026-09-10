return {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter").setup ({
            ensure_installed = { 'rust', 'cpp', 'c', 'python', 'lua', 'bash', 'vim', 'vimdoc', 'markdown', 'markdown_inline', 'latex' },
            sync_install = false,
            highlight = { enable = true, additional_vim_regex_highlighting = false, },
        })
    end,
}
