-- 1. 将 Neovim 的无名寄存器 (*) 与系统剪贴板 (+) 关联
vim.opt.clipboard = "unnamedplus"

-- 2. （可选）为 Visual 模式映射额外的快捷键
-- 习惯按 y 复制时，自动同步到系统剪贴板；也可以映射 Ctrl+C 直接复制
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- 强制侧边栏（SignColumn）始终显示，防止标志出现/消失时代码左侧来回抖动
vim.opt.signcolumn = "yes:2" -- 或者 "yes"
