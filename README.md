# Neovim 配置操作手册

> 多语言 (C/C++ · Rust · Python) 开发，集成嵌入式片上调试、自动格式化与原生 LSP；同时支持 Markdown / LaTeX / 纯文本写作。
> **插件管理器**: [lazy.nvim](https://github.com/folke/lazy.nvim)
> **Leader 键**: `<Space>`

---

## 目录

1. [文件树 (Neo-tree)](#1-文件树-neo-tree)
2. [内置终端 (Toggleterm)](#2-内置终端-toggleterm)
3. [窗口管理 (Smart-Splits)](#3-窗口管理-smart-splits)
4. [注释 (Comment.nvim)](#4-注释-commentnvim)
5. [自动配对符号 (nvim-autopairs)](#5-自动配对符号-nvim-autopairs)
6. [LSP 配置与定义跳转 (Mason + Telescope)](#6-lsp-配置与定义跳转-mason--telescope)
7. [代码格式化 (conform.nvim)](#7-代码格式化-conformnvim)
8. [Python 开发 (pyright + ruff)](#8-python-开发-pyright--ruff)
9. [Rust 开发 (Rustaceanvim)](#9-rust-开发-rustaceanvim)
10. [ARM 嵌入式调试 (DAP + OpenOCD + GDB)](#10-arm-嵌入式调试-dap--openocd--gdb)
11. [包围符号 (nvim-surround)](#11-包围符号-nvim-surround)
12. [语法高亮 (Treesitter)](#12-语法高亮-treesitter)
13. [彩虹括号 (rainbow-delimiters)](#13-彩虹括号-rainbow-delimiters)
14. [缩进指示线 (indent-blankline)](#14-缩进指示线-indent-blankline)
15. [平滑滚动 (neoscroll)](#15-平滑滚动-neoscroll)
16. [Markdown 渲染](#16-markdown-渲染)
17. [纯文本编辑](#17-纯文本编辑)
18. [LaTeX (VimTeX)](#18-latex-vimtex)
19. [完整快捷键速查表](#19-完整快捷键速查表)

---

## 1. 文件树 (Neo-tree)

**插件**: [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
**配置文件**: `lua/plugins/neo-tree.lua`

### 打开/关闭

| 快捷键 | 功能 |
|--------|------|
| `<Space>e` | 切换文件树 (左侧面板，宽 25 列) |

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
| `/` | 模糊搜索过滤 (树内实时高亮匹配) |
| `f` | 输入过滤条件，`Enter` 确认 |
| `zM` | 全部折叠 |
| `zR` | 全部展开 |
| `.` | 将光标下文件夹设为临时根目录 |
| `u` | 返回上一层根目录 |
| `<C-x>` / `<C-v>` | 水平/垂直分屏打开 |
| `R` | 刷新目录树 |
| `q` | 关闭 Neo-tree |

### 特性

- 打开文件时自动定位到当前文件 (`follow_current_file: true`)
- 显示所有文件，包括 `.gitignore` 中的项
- 文件树是最后一个窗口时允许关闭 (`close_if_last_window: true`)

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
- 可在终端中运行 `openocd`、`make`、`gdb` 等命令行工具

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
- 自动识别文件类型，支持 C、汇编 (`.s`/`.S`) 等嵌入式常见语言

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

## 6. LSP 配置与定义跳转 (Mason + Telescope)

**LSP 服务器管理**: [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) — `lua/plugins/mason.lua`
**LSP 配置**: [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — `lua/plugins/python.lua`
**快捷键与搜索**: `lua/config/keymaps.lua` + [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### LSP 服务器 (Mason 自动安装)

| 服务器 | 语言 | 状态 |
|--------|------|------|
| `clangd` | C/C++ | Mason 自动安装，供 C/C++ 项目使用 |
| `pyright` | Python | 已自动启用 (类型检查) |
| `ruff` | Python | 已自动启用 (lint) |

首次启动 Neovim 时 Mason 会自动安装缺失的服务器；也可以手动管理：

| 命令 | 功能 |
|------|------|
| `:Mason` | 打开 Mason 管理面板 (安装/卸载/更新服务器) |

> 嵌入式项目中建议生成 `compile_commands.json`（CMake: `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`，或使用 `bear` 工具），clangd 才能正确解析交叉编译的头文件和宏定义。

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

## 7. 代码格式化 (conform.nvim)

**插件**: [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
**配置文件**: `lua/plugins/c-cpp.lua` + `lua/plugins/python.lua`

### 保存时自动格式化

| 语言 | 工具 | 说明 |
|------|------|------|
| C/C++ | `clang-format` | `--style=file`，读取项目根目录 `.clang-format` 配置 |
| Python | `ruff_format` | ruff 自带格式化器 |

- **触发时机**: `BufWritePre` (保存前自动执行)
- **超时**: 5000ms
- **fallback**: 若格式化器不可用，退回到 LSP 格式化

### 手动命令

| 命令 | 功能 |
|------|------|
| `:ConformInfo` | 查看格式化状态和可用 formatter |

> 嵌入式项目中建议配置 `.clang-format` 以匹配团队代码风格。

---

## 8. Python 开发 (pyright + ruff)

**配置文件**: `lua/plugins/python.lua`

- **pyright**: 类型检查与智能补全
- **ruff**: 代码 lint + `ruff_format` 保存时格式化
- 两者均通过 nvim-lspconfig 自动启用，无需手动配置

通用 LSP 快捷键 (跳转/重命名/诊断) 见[第 6 节](#6-lsp-配置与定义跳转-mason--telescope)。

---

## 9. Rust 开发 (Rustaceanvim)

**插件**: [mrcjkb/rustaceanvim](https://github.com/mrcjkb/rustaceanvim)
**配置文件**: `lua/plugins/rust.lua`

### Rust-analyzer 特性

- **保存时 Clippy 检查**: `checkOnSave.command = "clippy"`，保存后自动运行 lints

> 可用于嵌入式 Rust (如 `no_std` + `cortex-m` 系列 crate) 开发。

通用 LSP 快捷键 (跳转/重命名/诊断) 见[第 6 节](#6-lsp-配置与定义跳转-mason--telescope)。

---

## 10. ARM 嵌入式调试 (DAP + OpenOCD + GDB)

**插件**: [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) + [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) + [theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)
**配置文件**: `lua/plugins/dap-arm.lua`

在 Neovim 内实现一键烧录 + 调试 ARM Cortex-M 芯片的完整工作流。

### 前置依赖

| 工具 | 用途 | 安装 |
|------|------|------|
| `arm-none-eabi-gdb` 或 `gdb-multiarch` | GDB 调试后端 | `apt install gdb-multiarch` |
| `openocd` | 片上调试服务器 (连接 DAPLink/ST-Link/J-Link) | `apt install openocd` |
| 调试器硬件 | DAPLink / ST-Link / J-Link | 物理连接目标 MCU |

### 项目结构要求

```
你的嵌入式项目/
├── openocd/
│   ├── stm32f1/daplink.cfg
│   ├── stm32f4/daplink.cfg
│   └── stm32h7/daplink.cfg
├── build/
│   └── main.elf          (编译产物)
└── src/
    └── main.c
```

### MCU 自动识别

根据 ELF 文件名自动推测 MCU 系列：

| 文件名包含 | 识别的 MCU | OpenOCD 配置 |
|------------|------------|---------------|
| `stm32f1`, `f103`, `bullet` | stm32f1 | `openocd/stm32f1/daplink.cfg` |
| `h7`, `mc02` | stm32h7 | `openocd/stm32h7/daplink.cfg` |
| 其他 (默认) | stm32f4 | `openocd/stm32f4/daplink.cfg` |

### ELF 文件定位逻辑

1. 首先在同目录查找 `<当前文件名>.elf`
2. 其次在 `build/` 目录查找 `build/<当前文件名>.elf`

### 一键烧录 + 调试

| 快捷键 | 功能 |
|--------|------|
| `<Space>dd` | 启动 ARM Flash & Debug 完整流程 |

**工作流程**:

1. 按 `<Space>dd`
2. 自动打开新标签页运行 `openocd -f openocd/<mcu>/daplink.cfg`
3. 等待 OpenOCD 连接调试器 (最多 5 秒)
4. 连接成功后通过 GDB 执行 `monitor reset halt` + `load` 烧录 ELF
5. 自动打开 DAP UI 调试面板

### 手动命令

| 命令 | 功能 |
|------|------|
| `:ArmDebug` | 手动触发 ARM Flash & Debug |

### DAP 调试面板 (nvim-dap-ui)

调试启动后自动显示：**Variables** · **Watch** · **Call Stack** · **Breakpoints** · **Scopes**

### DAP 调试快捷键

| 快捷键 | 功能 |
|--------|------|
| `<F5>` | 继续执行 (Continue) |
| `<F10>` | 单步跳过 (Step Over) |
| `<F11>` | 单步进入 (Step Into) |
| `<F12>` | 单步跳出 (Step Out) |
| `<Leader>db` | 切换断点 (Toggle Breakpoint) |
| `<Leader>dB` | 条件断点 |
| `<Leader>dr` | 打开 REPL |
| `<Leader>dl` | 运行到光标处 |

### 内联变量显示 (nvim-dap-virtual-text)

调试时在代码行尾直接显示变量值：

```c
int counter = 0;           // → counter = 42
uint32_t status = READY;   // → status = 0x0003
```

---

## 11. 包围符号 (nvim-surround)

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

## 12. 语法高亮 (Treesitter)

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

## 13. 彩虹括号 (rainbow-delimiters)

**插件**: [HiPhish/rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)
**配置文件**: `lua/plugins/rainbow.lua`

嵌套括号按层级着色，共 7 种颜色循环 (红/黄/蓝/橙/绿/紫/青)，深层次嵌套代码一目了然。Vim 文件使用局部作用域策略，其余语言使用全局策略。

---

## 14. 缩进指示线 (indent-blankline)

**插件**: [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
**配置文件**: `lua/plugins/indent-blankline.lua`

- 缩进线字符: `┊`
- 当前作用域高亮: 跨行代码块 (如函数体) 的起始/结束行画 `│` 水平指示线
- 在 help、neo-tree、mason、toggleterm 等面板中自动禁用

---

## 15. 平滑滚动 (neoscroll)

**插件**: [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)
**配置文件**: `lua/plugins/neoscroll.lua`

### 滚动快捷键

| 快捷键 | 功能 |
|--------|------|
| `<C-u>` | 向上平滑翻半页 (光标不动) |
| `<C-d>` | 向下平滑翻半页 (光标不动) |
| `<C-b>` | 向上平滑翻整页 (光标不动) |
| `<C-f>` | 向下平滑翻整页 (光标不动) |

### 特性

- 二次函数缓动曲线 (`quadratic`)，滚动自然流畅
- 到达文件边界时平滑停止 (`stop_eof: true`)

---

## 16. Markdown 渲染

**插件**: [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
**配置文件**: `lua/plugins/markdown.lua` + `after/ftplugin/markdown.lua`

Markdown 文件内实时渲染粗体、斜体、标题、链接、代码块等，所见即所得。

- Treesitter 额外安装 `markdown_inline` parser，支持行内元素渲染
- 打开 Markdown 文件自动启用拼写检查与软换行 (`spell` + `wrap` + `linebreak`)
- 缩进指示线在 Markdown 中自动禁用，保持排版干净

---

## 17. 纯文本编辑

**配置文件**: `after/ftplugin/text.lua`

打开 `.txt` 等纯文本文件时自动启用：

| 设置 | 说明 |
|------|------|
| `spell` | 拼写检查 (默认语言 `en`，可按需修改 `spelllang`) |
| `wrap` + `linebreak` | 长行软换行，仅在单词边界断行 |
| `breakindent` | 换行部分与行首缩进对齐 |

缩进指示线在纯文本中自动禁用。

---

## 18. LaTeX (VimTeX)

**插件**: [lervag/vimtex](https://github.com/lervag/vimtex)
**配置文件**: `lua/plugins/latex.lua` + `after/ftplugin/tex.lua`

完整的 LaTeX 编辑-编译-查看闭环。

### 前置依赖

| 工具 | 用途 | 安装 |
|------|------|------|
| `texlive` | LaTeX 发行版 (提供 latexmk) | `apt install texlive-latex-extra` |
| `zathura` | PDF 阅读器，支持 synctex 正反向搜索 | `apt install zathura zathura-pdf-poppler` |

> 未安装 zathura 时 VimTeX 自动回退到其他可用阅读器。

### 工作流

| 快捷键 | 功能 |
|--------|------|
| `,ll` | 编译 (latexmk 自动处理多遍编译) |
| `,lv` | 打开/跳转 PDF (正向搜索，光标位置同步到阅读器) |
| `,lt` | 文档大纲 (TOC) |
| `,le` | 错误列表 |
| `,lk` | 停止编译 |
| `,lc` | 清理辅助文件 |
| `,lq` | 编译日志 |
| `,lx` | 重新加载插件 |

反向搜索 (PDF → 源码) 由 VimTeX 自动配置，zathura 中 `Ctrl+鼠标左键` 跳回源码。

### 特性

- **localleader 已从 `\` 改为 `,`** (`lua/config/lazy.lua`)，避免与 LaTeX 命令冲突
- 拼写检查与软换行自动启用 (`after/ftplugin/tex.lua`)
- `conceallevel` 由 VimTeX 自动管理 (行内数学公式渲染)
- Treesitter 安装 `latex` 与 `bibtex` parser，语法高亮完整覆盖正文与参考文献
- 现有 `nvim-surround` 可直接用于 `\textbf{...}` 等命令包裹

---

## 19. 完整快捷键速查表

### 通用

| 快捷键 | 功能 |
|--------|------|
| `<Space>e` | 切换文件树 |
| `<C-t>` | 切换终端 |
| `<Space>th` | 水平终端 |
| `<C-c>` (Visual) | 复制到系统剪贴板 |
| `d` (Normal/Visual) | 删除 (不覆盖剪贴板，黑洞寄存器 `"_d`) |

### 滚动

| 快捷键 | 功能 |
|--------|------|
| `<C-u>` / `<C-d>` | 平滑翻半页 |
| `<C-b>` / `<C-f>` | 平滑翻整页 |

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

### ARM 调试

| 快捷键 | 功能 |
|--------|------|
| `<Space>dd` | ARM Flash & Debug (一键烧录+调试) |
| `:ArmDebug` | 手动触发 ARM 调试 |
| `<F5>` | 继续执行 |
| `<F10>` | 单步跳过 |
| `<F11>` | 单步进入 |
| `<F12>` | 单步跳出 |
| `<Leader>db` | 切换断点 |
| `<Leader>dB` | 条件断点 |

### LaTeX (localleader `,`)

| 快捷键 | 功能 |
|--------|------|
| `,ll` | 编译 (latexmk) |
| `,lv` | 打开/跳转 PDF (正向搜索) |
| `,lt` | 文档大纲 |
| `,le` | 错误列表 |
| `,lk` | 停止编译 |
| `,lc` | 清理辅助文件 |

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
| mason.nvim | https://github.com/williamboman/mason.nvim |
| nvim-lspconfig | https://github.com/neovim/nvim-lspconfig |
| nvim-treesitter | https://github.com/nvim-treesitter/nvim-treesitter |
| conform.nvim | https://github.com/stevearc/conform.nvim |
| rustaceanvim | https://github.com/mrcjkb/rustaceanvim |
| rainbow-delimiters.nvim | https://github.com/HiPhish/rainbow-delimiters.nvim |
| indent-blankline.nvim | https://github.com/lukas-reineke/indent-blankline.nvim |
| neoscroll.nvim | https://github.com/karb94/neoscroll.nvim |
| nvim-dap | https://github.com/mfussenegger/nvim-dap |
| nvim-dap-ui | https://github.com/rcarriga/nvim-dap-ui |
| nvim-dap-virtual-text | https://github.com/theHamsta/nvim-dap-virtual-text |
| render-markdown.nvim | https://github.com/MeanderingProgrammer/render-markdown.nvim |
| vimtex | https://github.com/lervag/vimtex |
| vscode.nvim (主题) | https://github.com/Mofiqul/vscode.nvim |
