-- highlight entrance of nvim-treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'rust', 'cpp', 'c', 'python', 'bash', 'vim', 'tex' },
  callback = function()
    vim.treesitter.start()
    pcall(function() vim.treesitter.get_parser(0):parse() end) -- first round force sync
  end,
})
