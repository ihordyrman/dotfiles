return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Issafalcon/neotest-dotnet",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet"),
        },
      })
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end,                        desc = "[T]est run nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,      desc = "[T]est run [F]ile" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,    desc = "[T]est [D]ebug nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,                 desc = "[T]est [S]ummary" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end,            desc = "[T]est [O]utput" },
    },
  },
}
