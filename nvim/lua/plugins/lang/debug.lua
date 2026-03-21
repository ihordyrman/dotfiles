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

      require("mason-nvim-dap").setup({
        ensure_installed = { "netcoredbg" },
        automatic_installation = true,
        handlers = {},
      })

      require("nvim-dap-virtual-text").setup({})

      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      require("which-key").add({ { "<leader>d", group = "[D]ebug" } })

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug Toggle [B]reakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "[D]ebug Conditional [B]reakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "[D]ebug [R]EPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "[D]ebug Run [L]ast" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[D]ebug Toggle [U]I" })
      vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "[D]ebug [T]erminate" })
    end,
  },
}
