-- 1. 将 Neovim 的无名寄存器 (*) 与系统剪贴板 (+) 关联
vim.opt.clipboard = "unnamedplus"

-- 2. （可选）为 Visual 模式映射额外的快捷键
-- 习惯按 y 复制时，自动同步到系统剪贴板；也可以映射 Ctrl+C 直接复制
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- 强制侧边栏（SignColumn）始终显示，防止标志出现/消失时代码左侧来回抖动
vim.opt.signcolumn = "yes:1" -- 或者 "yes"

vim.opt.tabstop = 4        -- Tab 宽度为 4
vim.opt.shiftwidth = 4     -- 自动缩进宽度为 4
vim.opt.softtabstop = 4    -- 编辑时按 Tab 视作 4 个空格
vim.opt.expandtab = true   -- 按 Tab 时转换为实际空格
