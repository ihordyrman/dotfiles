return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = { "mason-org/mason.nvim" },
    opts = {},
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "cs", "razor" },
        callback = function(args)
          vim.keymap.set("i", "///", function()
            local indent = vim.api.nvim_get_current_line():match("^%s*")
            local lines = {
              "/// <summary>",
              indent .. "/// ",
              indent .. "/// </summary>",
            }
            local row = vim.api.nvim_win_get_cursor(0)[1]
            vim.api.nvim_buf_set_lines(args.buf, row - 1, row, false, lines)
            vim.api.nvim_win_set_cursor(0, { row + 1, #indent + 4 })
          end, { buffer = args.buf })
        end,
      })

      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
        },
      })
    end,
  },
}
