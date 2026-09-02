-- One diagnostic sign per line, showing the WORST severity.
-- By default nvim places one sign per diagnostic, so a line with
-- 3 hints + 2 warnings + 2 errors overflows the sign column (HHWWEEE).
-- We override the built-in signs handler: group by line, keep the
-- highest severity, place a single sign (priority 10 → column 2,
-- gitsigns at priority 20 owns column 1).
local severity_rank = {
  [vim.diagnostic.severity.ERROR] = 4,
  [vim.diagnostic.severity.WARN] = 3,
  [vim.diagnostic.severity.INFO] = 2,
  [vim.diagnostic.severity.HINT] = 1,
}

local sign_by_severity = {
  [vim.diagnostic.severity.ERROR] = "DiagSignError",
  [vim.diagnostic.severity.WARN] = "DiagSignWarn",
  [vim.diagnostic.severity.INFO] = "DiagSignInfo",
  [vim.diagnostic.severity.HINT] = "DiagSignHint",
}

-- self-contained sign definitions (runtime's DiagnosticSign* are lazy-defined):
-- vscode-dark palette: error red / warn orange / info blue / hint gray
for _, def in ipairs({
  { "DiagSignError", "E", "#FF5555" },
  { "DiagSignWarn", "W", "#FFB86C" },
  { "DiagSignInfo", "I", "#569CD6" },
  { "DiagSignHint", "H", "#858585" },
}) do
  vim.api.nvim_set_hl(0, def[1], { fg = def[3] })
  vim.fn.sign_define(def[1], { text = def[2], texthl = def[1] })
end

local sign_group = "diag-sign-dedupe"
vim.api.nvim_create_namespace(sign_group)

vim.diagnostic.handlers.signs = {
  show = function(_, bufnr, diagnostics)
    -- clear previous pass
    vim.fn.sign_unplace(sign_group, { buffer = bufnr })

    local worst_by_line = {}
    for _, d in ipairs(diagnostics) do
      local cur = worst_by_line[d.lnum]
      if not cur or severity_rank[d.severity] > severity_rank[cur.severity] then
        worst_by_line[d.lnum] = d
      end
    end

    for lnum, d in pairs(worst_by_line) do
      vim.fn.sign_place(0, sign_group, sign_by_severity[d.severity], bufnr, {
        lnum = lnum + 1, -- sign API is 1-based, diagnostics are 0-based
        priority = 10, -- below gitsigns (20): git stays in column 1
      })
    end
  end,
  hide = function(_, bufnr)
    vim.fn.sign_unplace(sign_group, { buffer = bufnr })
  end,
}
