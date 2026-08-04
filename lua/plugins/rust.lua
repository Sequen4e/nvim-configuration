return { -- 1. Rust 专属神级插件（自动集成 rust-analyzer + DAP 调试）
  {
    'mrcjkb/rustaceanvim',
    version = 'v4', -- 推荐固定大版本
    ft = { 'rust' }, -- 仅在打开 Rust 文件时按需延迟加载
    config = function()
      vim.g.rustaceanvim = {
        -- LSP 语法检查配置
        server = {
          on_attach = function(client, bufnr)
            -- 绑定 Rust 专属 LSP 快捷键
            local opts = { buffer = bufnr }
            vim.keymap.set('n', 'K', '<cmd>RustLsp hover actions<cr>', opts)
            vim.keymap.set('n', '<leader>ca', '<cmd>RustLsp codeAction<cr>', opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          end,
          default_settings = {
            ['rust-analyzer'] = {
              -- 开启极速语法检查（保存时自动使用 clippy 检查）
              checkOnSave = {
                command = "clippy",
              },
              inlayHints = {
                enable = true, -- 显示内联类型提示 (Inlay Hints)
              },
            },
          },
        },
      }
    end
  },

  -- 2. 调试 UI 面板与基础 DAP 引擎
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      -- 当调试开始时自动打开 DAP UI 面板，调试结束自动关闭
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  }
}
