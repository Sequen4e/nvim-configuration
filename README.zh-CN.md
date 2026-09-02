<h1 align="center">nvim</h1>

<p align="center">
  <b>快速 · 极简 · 嵌入式优先</b><br/>
  面向<b>嵌入式开发</b>(C/C++ · Rust · Python)、技术写作(LaTeX · Markdown · 纯文本)
  与 AI 辅助编程的现代 Neovim 配置。
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-%E2%89%A5%200.12-57A143?logo=neovim" alt="Neovim" />
  <img src="https://img.shields.io/badge/插件管理器-lazy.nvim-2D2D2D?logo=lua" alt="lazy.nvim" />
  <img src="https://img.shields.io/badge/Leader-空格-FFB86C" alt="leader" />
</p>

<p align="center">
  🌐 <a href="README.md">English</a> · 中文
</p>

---

## 目录

- [特性](#-特性)
- [环境依赖](#-环境依赖)
- [安装](#-安装)
- [快捷键](#-快捷键)
- [目录结构](#-目录结构)
- [插件一览](#-插件一览)
- [指南](#-指南)
  - [C/C++ 与 clangd](#cc-与-clangd)
  - [ARM 烧录与调试](#arm-烧录与调试)
  - [LaTeX](#latex)
  - [Markdown 与纯文本](#markdown-与纯文本)
  - [添加新语言](#添加新语言)
- [外观](#-外观)

---

## ✨ 特性

- **极速启动**——全部插件按需加载;嵌入式调试栈与 AI 工具在你用到之前零开销。
- **三语言完整 LSP**——clangd、pyright + ruff、rust-analyzer:定义跳转、引用查找、重命名、代码操作。
- **一键 ARM 调试**——`<leader>dd` 经 OpenOCD + GDB 烧录并调试 Cortex-M 目标,自动识别 MCU。
- **写作全家桶**——Markdown 实时渲染、VimTeX + Synctex 正反向搜索、拼写检查与软换行。
- **AI 内置但可选**——blink.cmp 补全与 Claude Code 终端,均有独立开关;agent 统计(`/cost`、`/status`)原生可用。
- **编辑器内的 Git 状态**——行内 hunk 标记、逐 hunk 暂存/回退、整文件 diff 审查、行级 blame。

---

## 📦 环境依赖

| 用途 | 工具 |
|------|------|
| 基础 | Neovim ≥ 0.12 · git |
| C/C++ LSP | clangd(Mason 自动安装);完整语义需 `compile_commands.json`——[见指南](#cc-与-clangd) |
| 嵌入式调试 | `arm-none-eabi-gdb` 或 `gdb-multiarch` · `openocd` · ARM 工具链(`gcc-arm-none-eabi`) |
| LaTeX | TeX Live(提供 `latexmk`)· `zathura` + `zathura-pdf-poppler`(PDF 正反向搜索) |

> **clangd 提示:** 若 C++ 文件报 `'iostream' file not found`,见 [C/C++ 指南](#cc-与-clangd)。

## 🚀 安装

```bash
git clone https://github.com/<your-name>/<repo>.git ~/.config/nvim
nvim            # lazy.nvim 自动引导安装,随后装齐全部插件
:Mason          # 首次打开时安装 LSP 服务器 (clangd / pyright / ruff)
```

插件在启动时自动检查更新(lazy.nvim checker);手动管理用 `:Lazy`。

---

## ⌨️ 快捷键

Leader 为 <kbd>空格</kbd>(下文记为 `␣`),localleader 为 `,`(LaTeX 用)。

### 通用与编辑

| 按键 | 功能 |
|------|------|
| `q` | 清除搜索高亮 |
| `␣q` | 录制宏(原 `q`,后接寄存器名) |
| `gS` | 替换全部搜索高亮——进入 `:%s//`,输入 `新内容/g⏎` 全量,`新内容/gc⏎` 逐个确认 |
| `viwp` / 可视 `p` | 粘贴覆盖当前词——可视 `p` 已重映射为保留寄存器,反复 `viwp` 可用同一内容连续替换多个目标 |
| `H` / `L` | 跳到行首/行尾第一个非空白字符 |
| `_` / `g_` | 跳到屏幕顶部/底部 |
| `<C-a>` | 全选 |
| `U` | 重做 |
| `gcc` / `gc` | 行/区域注释切换 |
| `gbc` / `gb` | 块注释切换 |
| `<A-e>` | autopairs 快速包裹(给单词包上括号/引号) |
| `ys{文本对象}{字符}` · `ds{字符}` · `cs{旧}{新}` | 添加/删除/替换环绕对 |
| 可视 `S` | 环绕选中文本 |

### 导航与跳转

| 按键 | 功能 |
|------|------|
| `s` | Flash 标签跳转——输入标签跳到任意位置(normal/visual/operator-pending;运算符后按 `s` 即跳转作运动) |
| `f` / `F` / `t` / `T` | 原生逐字符导航(flash 的 char 模式已关闭) |
| `<C-u>` / `<C-d>` | 平滑滚动半页 |
| `<C-b>` / `<C-f>` | 平滑滚动整页 |
| `<C-h/j/k/l>` | 窗口间移动 |
| `<A-h/j/k/l>` | 调整窗口大小 |
| `␣w{hjkl}` | 窗口位置对调 |
| `␣e` | 开关文件树 |
| `<C-t>` / `␣th` | 开关终端 / 水平终端 |

### 文件树 (neo-tree)

| 按键 | 功能 |
|------|------|
| `/` | 模糊过滤(实时)——大目录导航的正解 |
| `f` | 输入过滤条件并应用 |
| `N` / `n` | 水平/垂直分屏打开 |
| `zM` / `zR` | 全部折叠 / 展开 |
| `.` / `u` | 设临时根目录 / 返回上层 |
| `R` / `q` | 刷新 / 关闭 |

### LSP(attach 后按 buffer 生效)

| 按键 | 功能 |
|------|------|
| `gd` / `gr` / `gy` / `gI` | 定义 / 引用 / 类型定义 / 实现(Telescope) |
| `K` / `gl` | 悬浮文档 / 行诊断 |
| `␣ds` / `␣ws` | 文件符号 / 项目符号 |
| `␣xx` | 全项目诊断列表 |
| `␣rn` / `␣ca` | 重命名 / 代码操作 |

### LaTeX(localleader `,`)

| 按键 | 功能 |
|------|------|
| `,ll` / `,lv` | 编译(latexmk)/ 查看 PDF(正向搜索) |
| `,lt` / `,le` | 文档大纲 / 错误列表 |
| `,lk` / `,lc` / `,lq` / `,lx` | 停止 / 清理 / 日志 / 重载 |

### ARM 调试

| 按键 | 功能 |
|------|------|
| `␣dd` / `:ArmDebug` | 一键烧录 + 调试(OpenOCD + GDB + DAP UI) |

### Git (gitsigns)

| 按键 | 功能 |
|------|------|
| `]c` / `[c` | 下一个 / 上一个 hunk |
| `␣hs` / `␣hr` | 暂存 / 回退当前 hunk |
| `␣hp` | 预览当前 hunk |
| `␣hd` | 审查:整文件与索引 diff |
| `␣hb` | 行级 blame |

### 开关

| 按键 | 功能 |
|------|------|
| `␣tc` | 开/关自动补全(blink.cmp) |
| `␣ac` / `␣aC` | 开/关 Claude Code 终端 / 续接最近会话 |

---

## 🗂️ 目录结构

```
~/.config/nvim
├── init.lua                     # 入口:lazy → keymaps → options
├── lua/
│   ├── config/
│   │   ├── lazy.lua             # lazy.nvim 引导、leader 键
│   │   ├── keymaps.lua          # 全局与 LSP 键位
│   │   └── options.lua          # 编辑器选项与自动命令
│   └── plugins/                 # 每个领域一个 spec 文件
│       ├── lsp.lua              # 全部 LSP 配置 + conform 格式化器(刻意集中于此)
│       ├── dap-arm.lua          # 嵌入式调试栈(懒加载)
│       ├── latex.lua · markdown.lua · blink.lua · claude.lua · flash.lua · gitsigns.lua
│       └── …                    # UI 与编辑类插件
└── after/ftplugin/              # 按文件类型的设置
    ├── tex.lua                  # 拼写、软换行、conceallevel=2
    ├── markdown.lua · text.lua  # 拼写、软换行
```

---

## 🧩 插件一览

| 插件 | 用途 | 配置 |
|------|------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 插件管理器 | `lua/config/lazy.lua` |
| [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | 暗色主题 | `colorscheme.lua` |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)(master) | 模糊查找与 LSP 选择器 | `telescope.lua` |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | 文件树 | `neo-tree.lua` |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 内置终端 | `toggleterm.lua` |
| [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim) | 窗口移动与缩放 | `smart-splits.lua` |
| [flash.nvim](https://github.com/folke/flash.nvim) | 标签跳转(`s`) | `flash.lua` |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | 环绕对 | `nvim-surround.lua` |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | 注释 | `comment.lua` |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 自动配对与快速包裹 | `autopairs.lua` |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 行内 git hunk 标记 | `gitsigns.lua` |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP 服务器安装器 | `mason.lua` |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 配置(clangd / pyright / ruff) | `lsp.lua` |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 保存时格式化 | `lsp.lua` |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Rust LSP + 保存时 clippy | `rust.lua` |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮与缩进(12 种 parser) | `treesitter.lua` |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | 彩虹括号 | `rainbow.lua` |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 缩进指示线 | `indent-blankline.lua` |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | 平滑滚动 | `neoscroll.lua` |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [dap-ui](https://github.com/rcarriga/nvim-dap-ui) + [virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | ARM 烧录与调试 | `dap-arm.lua` |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown 实时渲染 | `markdown.lua` |
| [vimtex](https://github.com/lervag/vimtex)(v2.18) | LaTeX 编译 / 查看 / Synctex | `latex.lua` |
| [blink.cmp](https://github.com/saghen/blink.cmp)(v1) | 补全(LSP / 路径 / buffer 词) | `blink.lua` |
| [claude-code.nvim](https://github.com/coder/claudecode.nvim) | Claude Code 终端 | `claude.lua` |

---

## 📖 指南

### C/C++ 与 clangd

clangd 只有**知道你的编译旗标**才能给出完整语义——这就是 `compile_commands.json` 的作用。没有它,跨文件符号解析失败并级联报错(「满屏红错」症状)。

每个项目生成一次:

| 构建系统 | 方式 |
|----------|------|
| CMake | `cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON`(configure 阶段即生成,**无需真正编译**;需要时软链 `build/compile_commands.json` 到项目根) |
| Makefile / 任意命令 | `bear -- make`(`sudo apt install bear`) |
| 轻量替代 | 项目根放 `compile_flags.txt`,每行一个旗标(如 `-I./inc`) |

> **`'iostream' file not found`?** 本配置自带两道保险:`--query-driver=/usr/bin/*`(clangd 直接询问真实编译器的 include 路径)与 `~/.config/clangd/config.yaml`(无数据库文件的回退编译器)。根因通常是已装 `gcc` 与 `libstdc++` 头文件版本不匹配——安装对应版本的 `g++-N` 可根治。

### ARM 烧录与调试

`<leader>dd`(或 `:ArmDebug`)执行完整流水线:

1. 定位 ELF:源文件同目录 `<当前名>.elf`,或 `build/<当前名>.elf`
2. 按 ELF 名识别 MCU:`stm32f1`/`f103`/`bullet` → STM32F1,`h7`/`mc02` → STM32H7,其余 → STM32F4
3. 在终端页启动 OpenOCD,使用 `openocd/<mcu>/daplink.cfg`
4. 等待探针、reset-halt、烧录,并打开 DAP UI

期望的项目结构:

```
project/
├── openocd/{stm32f1,stm32f4,stm32h7}/daplink.cfg
├── build/*.elf
└── src/*.c
```

整个调试栈(nvim-dap + dap-ui + virtual-text)懒加载——按下 `<leader>dd` 之前零开销。

### LaTeX

- 编译 `,ll`(latexmk)· 查看 `,lv`(zathura + Synctex 正向搜索;zathura 中 `Ctrl+点击` 跳回源码)
- 行内公式渲染(conceallevel)、拼写检查与软换行默认开启(`after/ftplugin/tex.lua`)
- 依赖 TeX Live 与 zathura——见[环境依赖](#-环境依赖)

### Markdown 与纯文本

- Markdown 实时渲染(粗体、标题、代码块);拼写与软换行开启
- `.txt` 享受同样的拼写/软换行
- 缩进指示线在 text/markdown/tex 中自动关闭,保持排版干净

### 添加新语言

三步走,一条铁律:

1. 在 `mason.lua` 的 `ensure_installed` 中加入对应 LSP 二进制
2. 在 `lsp.lua` 中:`vim.lsp.config["<server>"] = { cmd = { <mason 绝对路径> } }` + `vim.lsp.enable("<server>")`
3. (可选)在 conform 的 `formatters_by_ft` 添加格式化器

> **铁律:同一插件只能在一个 spec 文件中声明**——lazy.nvim 对多文件中的同名插件只执行一个 config。因此所有 LSP/conform 配置集中在 `lsp.lua`。

---

## 🎨 外观

- **主题**:vscode.nvim(暗色),自定义语法高亮组——VS Code 风格的 Rust/C/C++ 配色
- **缩进线**:`┊` 配当前作用域高亮;写作类文件自动禁用
- **彩虹括号**区分嵌套层级
- **Flash 高亮**跟随主题调色板(金色标签、橙色目标、灰色遮罩)
- **Gitsigns** 使用细竖条字形;双符号列——git 标记在第 1 列,诊断在第 2 列(每行一个符号,只显示最严重级别)

---

<p align="center">🌐 <a href="README.md">English</a> · 中文</p>
