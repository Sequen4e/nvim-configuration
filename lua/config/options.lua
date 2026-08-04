-- 1. 将 Neovim 的无名寄存器 (*) 与系统剪贴板 (+) 关联
vim.opt.clipboard = "unnamedplus"

-- 2. （可选）为 Visual 模式映射额外的快捷键
-- 习惯按 y 复制时，自动同步到系统剪贴板；也可以映射 Ctrl+C 直接复制
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- 强制侧边栏（SignColumn）始终显示，防止标志出现/消失时代码左侧来回抖动
vim.opt.signcolumn = "yes:2" -- 或者 "yes"

-- 1. 定义目标背景色（VS Code 暗色）
local vscode_bg = "#1E1E1E"

-- 2. 动态修改终端背景色的函数 (利用 OSC 11 序列)
local function set_terminal_bg(color)
  if vim.env.TMUX then
    -- 如果在 tmux 中，需要一层转义
    io.stdout:write("\27Ptmux;\27\27]11;" .. color .. "\007\27\\")
  else
    -- 标准 ANSI 终端（Gnome Terminal, Ptyxis, Alacritty, Kitty 等）
    io.stdout:write("\27]11;" .. color .. "\007")
  end
  io.stdout:flush()
end

-- 3. 创建自动命令 (Autocmd)
local bg_group = vim.api.nvim_create_augroup("TerminalBgSync", { clear = true })

-- 进入 Neovim 时：将终端背景色切换为 #1E1E1E
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter" }, {
  group = bg_group,
  callback = function()
    set_terminal_bg(vscode_bg)
  end,
})

-- 退出 Neovim 时：恢复终端原始背景色
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = bg_group,
  callback = function()
    -- \27]111\007 是 OSC 111 指令，意为“恢复终端默认背景色”
    if vim.env.TMUX then
      io.stdout:write("\27Ptmux;\27\27]111\007\27\\")
    else
      io.stdout:write("\27]111\007")
    end
    io.stdout:flush()
  end,
})
