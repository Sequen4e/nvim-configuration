-- LaTeX：拼写检查 + 软换行 + 行内数学符号渲染
-- （VimTeX 2.18 不再自动设置 conceallevel，需按官方文档手动开启）
vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.conceallevel = 2

-- VimTeX 常用 localleader 快捷键（由 VimTeX 自动注册，localleader 为 ","）：
--   ,ll 编译   ,lv 查看   ,lt 大纲   ,le 错误
--   ,lk 停止   ,lc 清理   ,lq 日志   ,lx 重载
