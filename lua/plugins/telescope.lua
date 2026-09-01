return {
    'nvim-telescope/telescope.nvim',
    -- master branch strongly recommend
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = { prompt_position = 'top' },
                sorting_strategy = 'ascending',
            },
        })
    end,
}
