-- =====================================================================
-- Preview mode (q toggle / Esc exit):
--   mounted ONLY while active, removed on exit -> outside preview every key
--   keeps its native meaning (d=delete, u=undo, y=yank, ...)
--   j/k/e/y = one line, d/u = half page (smooth), f/b = full page (smooth),
--   h/l = horizontal; nowait avoids prefix-wait against nvim-surround's ys/ds
-- =====================================================================
vim.g.preview_mode = false
local preview_buf = nil -- the buffer preview was activated on

local preview_scroll = {
    h = 'zh', l = 'zl',
    j = '<C-e>', k = '<C-y>', e = '<C-e>', y = '<C-y>',
    d = '<C-d>', u = '<C-u>',
    f = '<C-f>', b = '<C-b>',
}

local function set_preview(on)
    vim.g.preview_mode = on
    if on then
        preview_buf = vim.api.nvim_get_current_buf()
    end
    vim.o.relativenumber = not on
    vim.bo.modifiable = not on -- read-only in preview; edits raise E21
    for key, scroll in pairs(preview_scroll) do
        if on then
            vim.keymap.set('n', key, function()
                -- feedkeys replay; 'm' keeps neoscroll smoothness for C-d/u/f/b
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes(vim.v.count1 .. scroll, true, false, true),
                    'm', false)
            end, { desc = 'Preview scroll (' .. key .. ')', nowait = true })
        else
            pcall(vim.keymap.del, 'n', key)
        end
    end
    if on then
        vim.keymap.set('n', '<Esc>', function() set_preview(false) end, { desc = 'Exit preview', nowait = true })
    else
        pcall(vim.keymap.del, 'n', '<Esc>')
    end
    vim.notify(on and '-- PREVIEW --' or '-- PREVIEW OFF --', vim.log.levels.INFO)
end
vim.keymap.set('n', 'q', function() set_preview(not vim.g.preview_mode) end, { desc = 'Toggle preview mode' })

-- Leaving the preview buffer auto-exits (e.g. switching to neo-tree/terminal):
-- preview is bound to "the file I'm reading" — buffer-local mappings elsewhere
-- (neo-tree q=close, Esc=...) stay untouched
vim.api.nvim_create_autocmd('BufLeave', {
    callback = function(args)
        if vim.g.preview_mode and args.buf == preview_buf then
            set_preview(false)
        end
    end,
})
