return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      { "jay-babu/mason-nvim-dap.nvim", dependencies = { "mason-org/mason.nvim" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap").set_log_level("DEBUG")

      require("mason-nvim-dap").setup({
        ensure_installed = { "netcoredbg" },
        automatic_installation = true,
        handlers = {},
      })

      local netcoredbg_adapter = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" },
      }
      dap.adapters.netcoredbg = netcoredbg_adapter
      dap.adapters.coreclr = netcoredbg_adapter

      require("nvim-dap-virtual-text").setup({})

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "●", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapLogPoint",
        { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = "▶", texthl = "DapStopped", linehl = "DapStopped", numhl = "" }
      )

      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e51400" })
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#888888" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })

      dapui.setup({
        controls = { enabled = false },
        floating = { border = "rounded" },
        render = { max_type_length = 60, max_value_lines = 200 },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.4 },
              { id = "repl",   size = 0.6 },
            },
            size = 15,
            position = "bottom",
          },
        },
      })

      local last_dll_path = nil

      local function get_dll_path()
        local function detect()
          local cwd = vim.fn.getcwd()
          local project_name = vim.fn.fnamemodify(cwd, ":t")
          local dlls = vim.fn.glob(cwd .. "/**/bin/Debug/**/" .. project_name .. ".dll", false, true)
          if #dlls > 0 then
            table.sort(dlls, function(a, b) return vim.fn.getftime(a) > vim.fn.getftime(b) end)
            return dlls[1]
          end
          return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
        end

        if last_dll_path == nil then
          last_dll_path = detect()
        else
          if vim.fn.confirm("Reuse dll?\n" .. last_dll_path, "&yes\n&no", 1) == 2 then
            last_dll_path = detect()
          end
        end
        return last_dll_path
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch",
          request = "launch",
          console = "integratedTerminal",
          program = get_dll_path,
        },
        {
          type = "coreclr",
          name = "Attach",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      require("which-key").add({ { "<leader>d", group = "[D]ebug" } })

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set(
        "n",
        "<leader>db",
        dap.toggle_breakpoint,
        { desc = "[D]ebug Toggle [B]reakpoint" }
      )
      vim.keymap.set(
        "n",
        "<leader>dB",
        function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        { desc = "[D]ebug Conditional [B]reakpoint" }
      )
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "[D]ebug [R]EPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "[D]ebug Run [L]ast" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[D]ebug Toggle [U]I" })
      vim.keymap.set({ "n", "v" }, "Q", function() dapui.eval() end, { desc = "DAP peek expression" })
      vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "[D]ebug [T]erminate" })
      vim.keymap.set("n", "<leader>drr", function()
        vim.cmd("belowright 15split | terminal dotnet run")
      end, { desc = "[D]otnet [R]un" })
    end,
  },
}
