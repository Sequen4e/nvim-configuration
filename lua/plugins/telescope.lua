return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  -- 懒加载：首次使用 Telescope 命令/LSP 跳转时才加载（节省启动 ~10ms）
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
