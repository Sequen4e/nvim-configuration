-- Shared trigger: dap-ui / virtual-text load on the first debug action
local load_ui = function()
  vim.api.nvim_exec_autocmds("User", { pattern = "DapUiLoad" })
end
local function ui(fn)
  return function()
    load_ui()
    fn()
  end
end

return {
  -- =====================================================================
  -- nvim-dap core: generic software debugging + ARM flash & debug
  -- Standard keymaps are lazy `keys` entries: the first press loads the
  -- whole stack, then re-fires the action (lazy.nvim key handler behavior)
  -- =====================================================================
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", ui(function() require("dap").toggle_breakpoint() end), desc = "DAP: Toggle breakpoint" },
      { "<leader>dB", ui(function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end), desc = "DAP: Conditional breakpoint" },
      { "<F5>", ui(function() require("dap").continue() end), desc = "DAP: Continue" },
      { "<F10>", ui(function() require("dap").step_over() end), desc = "DAP: Step over" },
      { "<F11>", ui(function() require("dap").step_into() end), desc = "DAP: Step into" },
      { "<F12>", ui(function() require("dap").step_out() end), desc = "DAP: Step out" },
      { "<leader>dr", ui(function() require("dap").repl.open() end), desc = "DAP: Open REPL" },
      { "<leader>dl", ui(function() require("dap").run_to_cursor() end), desc = "DAP: Run to cursor" },
      { "<leader>dt", ui(function() require("dap").terminate() end), desc = "DAP: Terminate" },
      { "<leader>dd", ui(function() vim.cmd("ArmDebug") end), desc = "ARM Flash & Debug" },
    },
    config = function()
      local dap = require("dap")
      local mason_bin = function(pkg)
        return vim.fn.stdpath("data") .. "/mason/bin/" .. pkg
      end

      --------------------------------------------------------------------
      -- Adapters: codelldb (C/C++/Rust host), debugpy (Python), arm_gdb
      --------------------------------------------------------------------
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = mason_bin("codelldb"),
          args = { "--port", "${port}" },
        },
      }
      dap.adapters.debugpy = {
        type = "executable",
        command = mason_bin("debugpy-adapter"),
      }

      -- ARM Cortex-M adapter (deferred detection, see ensure_adapter)
      local function find_gdb()
        if vim.fn.executable("arm-none-eabi-gdb") == 1 then
          return "arm-none-eabi-gdb"
        elseif vim.fn.executable("gdb-multiarch") == 1 then
          return "gdb-multiarch"
        end
      end
      local function ensure_adapter()
        if dap.adapters.arm_gdb then
          return true
        end
        local gdb_path = find_gdb()
        if not gdb_path then
          vim.notify(
            "No ARM GDB found. Install arm-none-eabi-gdb or gdb-multiarch.",
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

      --------------------------------------------------------------------
      -- Launch configurations (select with :DapContinue / dap.run)
      --------------------------------------------------------------------
      local launch_file = function()
        return "${file}"
      end
      local launch_c = {
        {
          name = "Launch current file (codelldb)",
          type = "codelldb",
          request = "launch",
          program = launch_file(),
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = launch_c
      dap.configurations.cpp = launch_c
      dap.configurations.rust = {
        {
          name = "Launch current file (codelldb)",
          type = "codelldb",
          request = "launch",
          program = launch_file(),
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.python = {
        {
          name = "Launch current file (debugpy)",
          type = "debugpy",
          request = "launch",
          program = "${file}",
          console = "integratedTerminal",
        },
      }

      --------------------------------------------------------------------
      -- ARM flash & debug pipeline
      --------------------------------------------------------------------
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

      local function arm_flash_debug()
        if not vim.g.embedded_enabled then
          vim.notify(
            "Embedded features are disabled. Press <leader>td to enable.",
            vim.log.levels.WARN
          )
          return
        end
        if not ensure_adapter() then
          return
        end
        load_ui()

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
          cfg = vim.fn.getcwd() .. "/openocd/stm32f4/daplink.cfg"
        end

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
    end,
  },

  -- DAP UI panel: variables / scopes / call stack / breakpoints.
  -- Loads on the first debug action (User DapUiLoad), never at startup.
  {
    "rcarriga/nvim-dap-ui",
    event = "User DapUiLoad",
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

  -- Inline variable values during debug (same trigger)
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "User DapUiLoad",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
