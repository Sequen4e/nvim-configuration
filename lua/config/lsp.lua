-- Native LSP configuration (Neovim >= 0.11)
-- Replaces deprecated nvim-lspconfig for clangd.

-- clangd for C/C++
vim.lsp.config["clangd"] = {
  cmd = { "clangd-18", "--background-index", "--header-insertion=never" },
  filetypes = { "c", "cpp", "h", "hpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
}
vim.lsp.enable("clangd")
