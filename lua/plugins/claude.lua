return {
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume", "ClaudeCodeVerbose" },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
      { "<leader>aC", "<cmd>ClaudeCodeResume<CR>", desc = "Claude Code resume" },
    },
    config = function()
      require("claude-code").setup()
    end,
  },
}
