<h1 align="center">nvim</h1>

<p align="center">
  <b>Fast · Minimal · Embedded-first</b><br/>
  A modern Neovim configuration for <b>embedded development</b> (C/C++ · Rust · Python),
  technical writing (LaTeX · Markdown · prose), and AI-assisted coding.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-%E2%89%A5%200.12-57A143?logo=neovim" alt="Neovim" />
  <img src="https://img.shields.io/badge/plugin%20manager-lazy.nvim-2D2D2D?logo=lua" alt="lazy.nvim" />
  <img src="https://img.shields.io/badge/leader-Space-FFB86C" alt="leader" />
</p>

<p align="center">
  🌐 <a href="README.zh-CN.md">中文文档</a> · English
</p>

---

## Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Keymaps](#-keymaps)
- [File Structure](#-file-structure)
- [Plugins](#-plugins)
- [Guides](#-guides)
  - [C/C++ & clangd](#cc--clangd)
  - [ARM Flash & Debug](#arm-flash--debug)
  - [LaTeX](#latex)
  - [Markdown & Prose](#markdown--prose)
  - [Adding a New Language](#adding-a-new-language)
- [Appearance](#-appearance)

---

## ✨ Features

- **Blazing-fast startup** — everything is lazy-loaded; the embedded debug stack and AI tools cost *zero* until you ask for them.
- **Full LSP for three languages** — clangd, pyright + ruff, rust-analyzer: go-to-definition, references, rename, code actions.
- **One-key ARM debug** — `<leader>dd` flashes and debugs Cortex-M targets over OpenOCD + GDB, with automatic MCU detection.
- **Writing toolkit** — live Markdown rendering, VimTeX + Synctex forward/inverse search, spell-check and soft wrap for prose.
- **AI, built in but optional** — blink.cmp completion and Claude Code in a terminal; both behind explicit toggles, with agent stats (`/cost`, `/status`) for free.
- **Git in the gutter** — inline hunks, per-hunk stage/reset, buffer diff review, line blame.

---

## 📦 Prerequisites

| Purpose | Tools |
|---------|-------|
| Base | Neovim ≥ 0.12 · git |
| C/C++ LSP | clangd (auto-installed by Mason); a `compile_commands.json` for full project semantics — [see guide](#cc--clangd) |
| Embedded debug | `arm-none-eabi-gdb` or `gdb-multiarch` · `openocd` · ARM toolchain (`gcc-arm-none-eabi`) |
| LaTeX | TeX Live (provides `latexmk`) · `zathura` + `zathura-pdf-poppler` for PDF with forward/inverse search |

> **clangd note:** if clangd reports `'iostream' file not found` on C++ files, see the [C/C++ guide](#cc--clangd).

## 🚀 Installation

```bash
git clone https://github.com/<your-name>/<repo>.git ~/.config/nvim
nvim            # lazy.nvim bootstraps itself, then installs all plugins
:Mason          # first run installs LSP servers (clangd / pyright / ruff)
```

Plugins update automatically at startup (`lazy.nvim` checker); run `:Lazy` for manual management.

---

## ⌨️ Keymaps

Leader is <kbd>Space</kbd> (shown as `␣`), localleader is `,` (LaTeX).

### General & Editing

| Key | Action |
|-----|--------|
| `q` | Clear search highlight |
| `␣q` | Record macro (original `q`, followed by a register name) |
| `gS` | Replace all search matches — prompts `:%s//`, type `new/g⏎` (all) or `new/gc⏎` (confirm each) |
| `viwp` / visual `p` | Paste over a word — visual `p` is remapped to preserve the register, so repeated `viwp` replaces multiple targets with the same yank |
| `H` / `L` | Jump to first / last non-blank character of the line |
| `_` / `g_` | Jump to top / bottom of the screen |
| `<C-a>` | Select all |
| `U` | Redo |
| `gcc` / `gc` | Toggle line / range comment |
| `gbc` / `gb` | Toggle block comment |
| `<A-e>` | Autopairs fast-wrap (wrap a word with a delimiter) |
| `ys{text-object}{char}` · `ds{char}` · `cs{old}{new}` | Surround: add / delete / change a pair |
| visual `S` | Surround the visual selection |

### Navigation & Jumping

| Key | Action |
|-----|--------|
| `s` | Flash jump — type a label to jump anywhere (normal / visual / operator-pending: `ds`-style jumps work as motions) |
| `f` / `F` / `t` / `T` | Native char navigation (flash's char mode disabled) |
| `<C-u>` / `<C-d>` | Smooth scroll half page |
| `<C-b>` / `<C-f>` | Smooth scroll full page |
| `<C-h/j/k/l>` | Move between windows |
| `<A-h/j/k/l>` | Resize windows |
| `␣w{hjkl}` | Swap window positions |
| `␣e` | Toggle file tree |
| `<C-t>` / `␣th` | Toggle terminal / horizontal terminal |

### File Tree (neo-tree)

| Key | Action |
|-----|--------|
| `/` | Fuzzy filter (live) — *the* way to navigate large directories |
| `f` | Filter on submit |
| `N` / `n` | Open in horizontal / vertical split |
| `zM` / `zR` | Collapse / expand all |
| `.` / `u` | Set temporary root / navigate up |
| `R` / `q` | Refresh / close |

### LSP (attached per buffer)

| Key | Action |
|-----|--------|
| `gd` / `gr` / `gy` / `gI` | Definition / references / type definition / implementations (Telescope) |
| `K` / `gl` | Hover documentation / line diagnostics |
| `␣ds` / `␣ws` | Document / workspace symbols |
| `␣xx` | All workspace diagnostics |
| `␣rn` / `␣ca` | Rename symbol / code actions |

### LaTeX (localleader `,`)

| Key | Action |
|-----|--------|
| `,ll` / `,lv` | Compile (latexmk) / view PDF with forward search |
| `,lt` / `,le` | Table of contents / errors |
| `,lk` / `,lc` / `,lq` / `,lx` | Stop / clean / log / reload |

### ARM Debug

| Key | Action |
|-----|--------|
| `␣dd` / `:ArmDebug` | One-key flash & debug (OpenOCD + GDB + DAP UI) |

### Git (gitsigns)

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous hunk |
| `␣hs` / `␣hr` | Stage / reset current hunk |
| `␣hp` | Preview hunk |
| `␣hd` | Review: diff entire buffer vs index |
| `␣hb` | Blame current line |

### Toggles

| Key | Action |
|-----|--------|
| `␣tc` | Toggle completion (blink.cmp) |
| `␣ac` / `␣aC` | Toggle Claude Code terminal / resume latest session |

---

## 🗂️ File Structure

```
~/.config/nvim
├── init.lua                     # entry: lazy → keymaps → options
├── lua/
│   ├── config/
│   │   ├── lazy.lua             # lazy.nvim bootstrap, leader keys
│   │   ├── keymaps.lua          # global + LSP keymaps
│   │   └── options.lua          # editor options, autocmds
│   └── plugins/                 # one spec file per domain
│       ├── lsp.lua              # ALL LSP configs + conform formatters (single file by design)
│       ├── dap-arm.lua          # embedded debug stack (lazy)
│       ├── latex.lua · markdown.lua · blink.lua · claude.lua · flash.lua · gitsigns.lua
│       └── …                    # UI / editing plugins
└── after/ftplugin/              # per-filetype settings
    ├── tex.lua                  # spell, soft wrap, conceallevel=2
    ├── markdown.lua · text.lua  # spell, soft wrap
```

---

## 🧩 Plugins

| Plugin | Purpose | Config |
|--------|---------|--------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager | `lua/config/lazy.lua` |
| [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | Dark colorscheme | `colorscheme.lua` |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (master) | Fuzzy finder & LSP pickers | `telescope.lua` |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer | `neo-tree.lua` |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal | `toggleterm.lua` |
| [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim) | Window movement & resizing | `smart-splits.lua` |
| [flash.nvim](https://github.com/folke/flash.nvim) | Label jump (`s`) | `flash.lua` |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround pairs | `nvim-surround.lua` |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Comments | `comment.lua` |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto pairs & fast-wrap | `autopairs.lua` |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git hunks in the gutter | `gitsigns.lua` |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP server installer | `mason.lua` |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP setup (clangd / pyright / ruff) | `lsp.lua` |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save | `lsp.lua` |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Rust LSP + clippy on save | `rust.lua` |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Highlighting & indentation (12 parsers) | `treesitter.lua` |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | Rainbow brackets | `rainbow.lua` |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides | `indent-blankline.lua` |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling | `neoscroll.lua` |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [dap-ui](https://github.com/rcarriga/nvim-dap-ui) + [virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | ARM flash & debug | `dap-arm.lua` |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Live Markdown rendering | `markdown.lua` |
| [vimtex](https://github.com/lervag/vimtex) (v2.18) | LaTeX compile / view / Synctex | `latex.lua` |
| [blink.cmp](https://github.com/saghen/blink.cmp) (v1) | Completion (LSP / path / buffer) | `blink.lua` |
| [claude-code.nvim](https://github.com/coder/claudecode.nvim) | Claude Code in a terminal | `claude.lua` |

---

## 📖 Guides

### C/C++ & clangd

clangd provides semantic analysis **only if it knows your build flags** — that's what `compile_commands.json` is for. Without it, cross-file symbols fail with cascading errors (the "errors everywhere" symptom).

Generate it once per project:

| Build system | How |
|--------------|-----|
| CMake | `cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON` (the file is produced at *configure* time — no compile needed; symlink `build/compile_commands.json` to the project root if needed) |
| Makefile / anything | `bear -- make` (`sudo apt install bear`) |
| Quick fallback | Put a `compile_flags.txt` in the project root (one flag per line, e.g. `-I./inc`) |

> **`'iostream' file not found`?** This config ships two safeguards: `--query-driver=/usr/bin/*` (clangd asks your real compiler for include paths) and `~/.config/clangd/config.yaml` (fallback compiler for database-less files). The root cause is usually a version mismatch between installed `gcc` and the `libstdc++` headers — installing the matching `g++-N` fixes it permanently.

### ARM Flash & Debug

`<leader>dd` (or `:ArmDebug`) runs the whole pipeline:

1. Resolve the ELF: `<current>.elf` next to the source, or `build/<current>.elf`
2. Guess the MCU from the ELF name: `stm32f1`/`f103`/`bullet` → STM32F1, `h7`/`mc02` → STM32H7, otherwise → STM32F4
3. Start OpenOCD in a terminal tab using `openocd/<mcu>/daplink.cfg`
4. Wait for the probe, reset-halt, flash, and attach the DAP UI

Expected project layout:

```
project/
├── openocd/{stm32f1,stm32f4,stm32h7}/daplink.cfg
├── build/*.elf
└── src/*.c
```

The whole debug stack (nvim-dap + dap-ui + virtual-text) is lazy — it costs nothing until you press `<leader>dd`.

### LaTeX

- Compile: `,ll` (latexmk) · view: `,lv` (zathura + Synctex forward search; `Ctrl+Click` in zathura jumps back)
- Conceal renders inline math; spell-check and soft wrap are on by default (`after/ftplugin/tex.lua`)
- Requires TeX Live and zathura — see [Prerequisites](#-prerequisites)

### Markdown & Prose

- Markdown renders live (bold, headings, code blocks); spell-check and soft wrap on
- `.txt` gets the same spell/wrap treatment
- Indent guides are disabled in text/markdown/tex to keep prose clean

### Adding a New Language

Three steps, one rule:

1. Add the LSP server binary to `ensure_installed` in `mason.lua`
2. In `lsp.lua`: `vim.lsp.config["<server>"] = { cmd = { <absolute mason bin path> } }` + `vim.lsp.enable("<server>")`
3. (Optional) Add a formatter to conform's `formatters_by_ft`

> **Rule:** a given plugin must be declared in exactly *one* spec file — lazy.nvim executes only one `config` when the same plugin appears in multiple files. That's why all LSP/conform configs live together in `lsp.lua`.

---

## 🎨 Appearance

- **Colorscheme**: vscode.nvim (dark) with custom group overrides — VS Code-style syntax colors tuned for Rust/C/C++
- **Indent guides**: `┊` with scope highlighting; disabled in prose files
- **Rainbow delimiters** for nested brackets
- **Flash highlights** follow the theme palette (gold labels, orange targets, gray backdrop)
- **Gitsigns** uses subtle bar glyphs in the sign column

---

<p align="center">🌐 <a href="README.zh-CN.md">中文文档</a> · English</p>
