# Neovim 配置操作手册 — `master` 分支

> **分支定位**: 通用 C/C++/Rust 开发环境，`embedded-conf` 分支在此基础上增加 ARM 嵌入式调试。
> **插件管理器**: [lazy.nvim](https://github.com/folke/lazy.nvim)
> **Leader 键**: `<Space>`

---

## 目录

1. [文件树 (Neo-tree)](#1-文件树-neo-tree)
2. [内置终端 (Toggleterm)](#2-内置终端-toggleterm)
3. [窗口管理 (Smart-Splits)](#3-窗口管理-smart-splits)
4. [注释 (Comment.nvim)](#4-注释-commentnvim)
5. [自动配对符号 (nvim-autopairs)](#5-自动配对符号-nvim-autopairs)
6. [LSP 配置与定义跳转](#6-lsp-配置与定义跳转)
7. [代码格式化 (conform.nvim + clang-format)](#7-代码格式化-conformnvim--clang-format)
8. [包围符号 (nvim-surround)](#8-包围符号-nvim-surround)
9. [语法高亮 (Treesitter)](#9-语法高亮-treesitter)
10. [Rust 开发 (Rustaceanvim + DAP)](#10-rust-开发-rustaceanvim--dap)
11. [Markdown 渲染](#11-markdown-渲染)
12. [完整快捷键速查表](#12-完整快捷键速查表)

---

## 1. 文件树 (Neo-tree)

**插件**: [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
**配置文件**: `lua/plugins/neo-tree.lua`

### 打开/关闭

| 快捷键 | 功能 |
|--------|------|
| `<Space>e` | 切换文件树 (左侧面板) |

### 文件树内操作

| 按键 | 功能 |
|------|------|
| `Enter` | 打开文件/目录 |
| `a` | 新建文件 |
| `d` | 删除文件/目录 |
| `r` | 重命名 |
| `m` | 移动 |
| `c` | 复制 |
| `H` | 切换显示隐藏文件 |
| `/` | 搜索文件 (模糊匹配) |
| `<C-x>` / `<C-v>` | 水平/垂直分屏打开 |
| `R` | 刷新目录树 |
| `q` | 关闭 Neo-tree |

### 特性

- 窗口宽度 30 列，位于左侧
- 打开文件时自动定位到当前文件 (`follow_current_file: true`)
- 显示所有文件，包括 `.gitignore` 中的项 (`visible: true`)

---

## 2. 内置终端 (Toggleterm)

**插件**: [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
**配置文件**: `lua/plugins/toggleterm.lua`

### 打开/关闭

| 快捷键 | 功能 |
|--------|------|
| `<C-t>` | 切换底部终端面板 (水平方向，高度 15 行) |
| `<Space>th` | 水平方向打开终端 |

### 终端模式快捷键

| 按键 | 功能 |
|------|------|
| `<Esc><Esc>` | 从终端输入模式切回 Normal 模式 |
| `<C-k>` | 从终端切回上方代码窗口 |

### 特性

- 高度固定 15 行，关闭后记住上次大小
- 退出 shell 后自动关闭终端窗口
- 终端背景带阴影效果

---

## 3. 窗口管理 (Smart-Splits)

**插件**: [mrjones2014/smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim)
**配置文件**: `lua/plugins/smart-splits.lua`

### 窗口间移动 (无缝切换)

| 快捷键 | 功能 |
|--------|------|
| `<C-h>` | 切到左侧窗口 |
| `<C-j>` | 切到下方窗口 |
| `<C-k>` | 切到上方窗口 |
| `<C-l>` | 切到右侧窗口 |

### 调整窗口大小

| 快捷键 | 功能 |
|--------|------|
| `<A-h>` | 向左拉伸/压缩 |
| `<A-j>` | 向下拉伸/压缩 |
| `<A-k>` | 向上拉伸/压缩 |
| `<A-l>` | 向右拉伸/压缩 |

> 按下后进入 resize 模式，用 `h/j/k/l` 微调，`<Esc>` 退出。

### 窗口位置互换

| 快捷键 | 功能 |
|--------|------|
| `<Space>wh` | 当前窗口与左侧对调 |
| `<Space>wj` | 当前窗口与下方对调 |
| `<Space>wk` | 当前窗口与上方对调 |
| `<Space>wl` | 当前窗口与右侧对调 |

---

## 4. 注释 (Comment.nvim)

**插件**: [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
**配置文件**: `lua/plugins/comment.lua`

### 注释操作

| 快捷键 | 功能 |
|--------|------|
| `gcc` | 注释/取消注释当前行 |
| `gc` + 动作 | 注释目标区域 (如 `gc2j` 注释当前行及下 2 行) |
| `gbc` | 块注释当前行 |
| `gb` + 动作 | 块注释目标区域 |

> **Visual 模式**: 选中文本后按 `gc` 注释整块。

### 特性

- 注释符号与代码间自动加空格
- 注释后光标保持原位 (`sticky: true`)
- 自动识别文件类型使用正确的注释符号

---

## 5. 自动配对符号 (nvim-autopairs)

**插件**: [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
**配置文件**: `lua/plugins/autopairs.lua`

### 自动配对

输入 `(` → 自动补全 `(|)`，光标位于中间。
支持: `()` `[]` `{}` `""` `''`

### 功能细节

| 行为 | 说明 |
|------|------|
| 自动跳过右括号 | 光标前已有 `)` 时按 `)` 不重复输入，直接跳过 |
| 智能退格 | 光标在 `(|)` 中按退格，同时删除左右括号 |
| 快速包裹 | `<A-e>` 将光标后单词用括号包裹 |
| Treesitter 校验 | 不在字符串/注释内误补全 |

### 快速包裹 (FastWrap)

插入模式下按 `<A-e>`，自动选中光标后单词，再按 `(` / `"` / `'` 等即完成包裹。

---

## 6. LSP 配置与定义跳转

**LSP 配置文件**: `lua/config/lsp.lua` + `lua/config/keymaps.lua`
**搜索后端**: [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### C/C++ LSP (clangd)

Neovim 原生 LSP 配置，不依赖 `nvim-lspconfig`：

- **后端**: `clangd-18`
- **参数**: `--background-index` (后台索引), `--header-insertion=never` (不自动插入头文件)
- **支持文件类型**: `c`, `cpp`, `h`, `hpp`
- **根目录识别**: `compile_commands.json` > `compile_flags.txt` > `.git`

### Rust LSP

由 `rustaceanvim` 内置集成 `rust-analyzer`，详见[第 10 节](#10-rust-开发-rustaceanvim--dap)。

### 核心跳转快捷键

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `gd` | 跳转到定义 | Telescope 弹窗选择 (仅一个定义时直接跳转) |
| `gr` | 查找所有引用 | Telescope 实时预览 |
| `gy` | 跳转到类型定义 | Type Definition |
| `gI` | 跳转到实现 | Interface/Trait 的具体实现 |
| `K` | 悬浮文档 | 原生浮动窗口，显示符号签名与文档 |
| `gl` | 行诊断 | 浮动窗口显示当前行错误/警告 |

### 符号搜索

| 快捷键 | 功能 |
|--------|------|
| `<Space>ds` | 搜索当前文件符号 (函数/结构体/变量) |
| `<Space>ws` | 搜索全项目符号 |

### 诊断与重构

| 快捷键 | 功能 |
|--------|------|
| `<Space>xx` | 列出全项目诊断错误/警告 (Telescope) |
| `<Space>rn` | 重命名符号 |
| `<Space>ca` | 代码操作 (修复建议/重构) |

### Telescope 通用操作

| 按键 | 功能 |
|------|------|
| `<C-n>` / `<C-p>` | 下/上一个候选项 |
| `<C-u>` / `<C-d>` | 上/下半页滚动预览 |
| `<CR>` | 确认选择 |
| `<C-x>` / `<C-v>` | 水平/垂直分屏打开 |
| `<C-t>` | 在新标签页打开 |
| `<Esc>` | 关闭 Telescope |

---

## 7. 代码格式化 (conform.nvim + clang-format)

**插件**: [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
**配置文件**: `lua/plugins/c-cpp.lua` (symlink → Embedded-nvim)

### C/C++ 保存时自动格式化

- **触发时机**: `BufWritePre` (保存前自动执行)
- **命令**: `clang-format --style=file` (读取项目根目录 `.clang-format` 配置)
- **超时**: 5000ms
- **fallback**: 若 `clang-format` 不可用，退回到 LSP 格式化

### 手动命令

| 命令 | 功能 |
|------|------|
| `:ConformInfo` | 查看格式化状态和可用 formatter |

---

## 8. 包围符号 (nvim-surround)

**插件**: [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
**配置文件**: `lua/plugins/nvim-surround.lua`

### 包围操作

| 快捷键 | 功能 | 示例 |
|--------|------|------|
| `ys{motion}{char}` | 添加包围符 | `ysiw"` → 单词外加双引号 |
| `ds{char}` | 删除包围符 | `ds"` → 删除最近的 `"..."` |
| `cs{old}{new}` | 替换包围符 | `cs"'` → 双引号换单引号 |
| `S{char}` (Visual) | 包围选中文本 | 选中后按 `S(` → `(selected text)` |

### 常用例子

```
ysiw(      → (word)
ysiw"      → "word"
ds(        → 去掉括号
cs"'       → "hello" → 'hello'
cst<div>   → <div>hello</div>  (t = tag)
```

---

## 9. 语法高亮 (Treesitter)

**插件**: [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
**配置文件**: `lua/plugins/treesitter.lua`

### 已安装语言

`rust` · `lua` · `vim` · `vimdoc` · `python` · `c` · `cpp` · `bash` · `markdown`

### 功能

- **语法高亮**: Treesitter 接管所有高亮 (禁用 LSP semantic tokens)
- **智能缩进**: `indent: true`

### 常用命令

| 命令 | 功能 |
|------|------|
| `:TSUpdate` | 更新所有 Treesitter parser |
| `:TSInstallInfo` | 查看已安装 parser |
| `:TSInstall {lang}` | 安装指定语言 parser |

---

## 10. Rust 开发 (Rustaceanvim + DAP)

**插件**: [mrcjkb/rustaceanvim](https://github.com/mrcjkb/rustaceanvim) + [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
**配置文件**: `lua/plugins/rust.lua`

### Rust 特有快捷键

| 快捷键 | 功能 |
|--------|------|
| `K` | Rust 增强 hover (支持 actions) |
| `<Space>ca` | Rust 代码操作 |
| `gd` | 原生 LSP 跳转定义 |

### Rust-analyzer 特性

- **保存时 Clippy 检查**: `checkOnSave.command = "clippy"`
- **内联类型提示**: `inlayHints.enable = true`

### DAP 调试

启动调试时 DAP UI 面板自动打开，停止/退出时自动关闭。

> 需要安装对应调试器 (如 `codelldb` 或 `lldb-vscode`)。

---

## 11. Markdown 渲染

**插件**: [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
**配置文件**: `lua/plugins/markdown.lua`

Markdown 文件内实时渲染粗体、斜体、标题、链接、代码块等，所见即所得。

---

## 12. 完整快捷键速查表

### 通用

| 快捷键 | 功能 |
|--------|------|
| `<Space>e` | 切换文件树 |
| `<C-t>` | 切换终端 |
| `<Space>th` | 水平终端 |
| `<C-c>` (Visual) | 复制到系统剪贴板 |
| `d` (Normal/Visual) | 删除 (不覆盖剪贴板，黑洞寄存器 `"_d`) |

### 窗口管理

| 快捷键 | 功能 |
|--------|------|
| `<C-h/j/k/l>` | 窗口间移动 |
| `<A-h/j/k/l>` | 调整窗口大小 |
| `<Space>w{h/j/k/l}` | 窗口位置对调 |

### LSP / 代码导航

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转定义 (Telescope) |
| `gr` | 查找引用 (Telescope) |
| `gy` | 跳转类型定义 (Telescope) |
| `gI` | 跳转实现 (Telescope) |
| `K` | 悬浮文档 |
| `gl` | 行诊断浮窗 |
| `<Space>ds` | 文件符号搜索 |
| `<Space>ws` | 项目符号搜索 |
| `<Space>xx` | 项目诊断列表 |
| `<Space>rn` | 重命名 |
| `<Space>ca` | 代码操作 |

### Rust 调试 (DAP)

| 快捷键 | 功能 |
|--------|------|
| `<F5>` | 继续执行 |
| `<F10>` | 单步跳过 |
| `<F11>` | 单步进入 |
| `<F12>` | 单步跳出 |
| `<Leader>db` | 切换断点 |

### 注释

| 快捷键 | 功能 |
|--------|------|
| `gcc` | 注释当前行 |
| `gc<motion>` | 注释范围 |
| `gbc` | 块注释当前行 |

### 包围符号

| 快捷键 | 功能 |
|--------|------|
| `ys<motion><char>` | 添加包围 |
| `ds<char>` | 删除包围 |
| `cs<old><new>` | 替换包围 |
| `S<char>` (Visual) | 包围选中文本 |

### 插入模式

| 快捷键 | 功能 |
|--------|------|
| `<A-e>` | 快速包裹 (autopairs) |
| `(` `[` `{` `"` `'` | 自动配对 |

---

## 插件链接汇总

| 插件 | 文档 |
|------|------|
| lazy.nvim | https://github.com/folke/lazy.nvim |
| neo-tree.nvim | https://github.com/nvim-neo-tree/neo-tree.nvim |
| toggleterm.nvim | https://github.com/akinsho/toggleterm.nvim |
| smart-splits.nvim | https://github.com/mrjones2014/smart-splits.nvim |
| Comment.nvim | https://github.com/numToStr/Comment.nvim |
| nvim-autopairs | https://github.com/windwp/nvim-autopairs |
| nvim-surround | https://github.com/kylechui/nvim-surround |
| telescope.nvim | https://github.com/nvim-telescope/telescope.nvim |
| nvim-treesitter | https://github.com/nvim-treesitter/nvim-treesitter |
| conform.nvim | https://github.com/stevearc/conform.nvim |
| rustaceanvim | https://github.com/mrcjkb/rustaceanvim |
| nvim-dap | https://github.com/mfussenegger/nvim-dap |
| nvim-dap-ui | https://github.com/rcarriga/nvim-dap-ui |
| render-markdown.nvim | https://github.com/MeanderingProgrammer/render-markdown.nvim |
| vscode.nvim (主题) | https://github.com/Mofiqul/vscode.nvim |
