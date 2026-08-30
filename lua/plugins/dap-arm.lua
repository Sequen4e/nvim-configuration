return {
  -- nvim-dap core + ARM Cortex-M adapter
  {
    "mfussenegger/nvim-dap",
    -- 懒加载：仅在触发烧录/调试命令时加载，不占用日常启动时间
    cmd = "ArmDebug",
    keys = {
      { "<leader>dd", desc = "ARM Flash & Debug" },
    },
    config = function()
      local dap = require("dap")

      -- ── helper: detect GDB variant ──
      local function find_gdb()
        if vim.fn.executable("arm-none-eabi-gdb") == 1 then
          return "arm-none-eabi-gdb"
        elseif vim.fn.executable("gdb-multiarch") == 1 then
          return "gdb-multiarch"
        end
      end

      -- ── 延迟检测 GDB：命令注册与 GDB 存在性解耦（配合懒加载，首次触发时才检查）──
      local function ensure_adapter()
        if dap.adapters.arm_gdb then
          return true
        end
        local gdb_path = find_gdb()
        if not gdb_path then
          vim.notify(
            "embedded-nvim: No ARM GDB found. Install arm-none-eabi-gdb or gdb-multiarch.",
            vim.log.levels.WARN
          )
          return false
        end
        dap.adapters.arm_gdb = {
          type = "executable",
          command = gdb_path,
          args = { "-q", "--interpreter=dap" },
        }
        return true
      end

      -- ── wait for OpenOCD on :3333 ──
      local function wait_openocd(timeout_ms)
        timeout_ms = timeout_ms or 10000
        local start = vim.loop.now()
        while (vim.loop.now() - start) < timeout_ms do
          local sock = vim.loop.new_tcp()
          local ok = false
          sock:connect("127.0.0.1", 3333, function(err)
            if not err then ok = true end
          end)
          vim.wait(300)
          if ok then
            sock:close()
            return true
          end
          sock:close()
        end
        return false
      end

      -- ── guess MCU family from elf path ──
      local function guess_mcu(elf)
        local lower = elf:lower()
        if lower:find("stm32f1") or lower:find("f103") or lower:find("bullet") then
          return "stm32f1"
        elseif lower:find("h7") or lower:find("mc02") then
          return "stm32h7"
        else
          return "stm32f4"
        end
      end

      -- ── Flash & Debug action ──
      local function arm_flash_debug()
        if not ensure_adapter() then
          return
        end

        -- 调试正式开始：加载 UI 与虚拟文本插件
        vim.api.nvim_exec_autocmds("User", { pattern = "DapArmDebugStart" })

        -- resolve ELF
        local elf = vim.fn.expand("%:p:r") .. ".elf"
        local build_elf = vim.fn.findfile(
          "build/" .. vim.fn.expand("%:t:r") .. ".elf",
          vim.fn.getcwd() .. ";"
        )
        if build_elf ~= "" then elf = vim.fn.fnamemodify(build_elf, ":p") end
        if vim.fn.filereadable(elf) == 0 then
          vim.notify("ELF not found: " .. elf, vim.log.levels.ERROR)
          return
        end

        local mcu = guess_mcu(elf)
        local cfg = vim.fn.getcwd() .. "/openocd/" .. mcu .. "/daplink.cfg"
        if vim.fn.filereadable(cfg) == 0 then
          -- fallback: use UICRM-style openocd dir
          cfg = vim.fn.getcwd() .. "/openocd/stm32f4/daplink.cfg"
        end

        -- start OpenOCD in a terminal tab
        vim.cmd("tabnew")
        vim.cmd("terminal openocd -f " .. cfg)
        vim.cmd("tabprevious")
        vim.notify("Waiting for OpenOCD probe...", vim.log.levels.INFO)

        if not wait_openocd(5000) then
          vim.notify("OpenOCD timeout. Check the terminal tab.", vim.log.levels.WARN)
        end

        dap.run({
          name = "ARM Debug",
          type = "arm_gdb",
          request = "launch",
          program = elf,
          stopAtBeginningOfMainSubprogram = false,
          target = "extended-remote :3333",
          preLaunchCommands = {
            "monitor reset halt",
            "load",
          },
        })
      end

      vim.api.nvim_create_user_command("ArmDebug", arm_flash_debug, { force = true })
      vim.keymap.set("n", "<leader>dd", arm_flash_debug, { desc = "ARM Flash & Debug" })
    end,
  },

  -- DAP UI panel（由 User DapArmDebugStart 事件触发，调试启动时才加载；
  -- 注意：无任何触发器的 spec 会被 lazy 视为 eager，启动即加载）
  {
    "rcarriga/nvim-dap-ui",
    event = "User DapArmDebugStart",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Inline variable values during debug（同上）
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "User DapArmDebugStart",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
