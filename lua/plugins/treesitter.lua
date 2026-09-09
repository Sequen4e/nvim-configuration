return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- old master branch is frozen upstream; active development is on main
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = { "rust", "lua", "vim", "vimdoc", "python", "c", "cpp", "bash", "markdown", "markdown_inline", "latex", "bibtex" },
    },
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)

        -- main arch: highlighting is provided by nvim core (see :h treesitter-highlight)
        local function start_hl(buf)
            if vim.bo[buf].buftype == "" and vim.bo[buf].filetype ~= "" then
                pcall(vim.treesitter.start, buf)
            end
        end
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(a) start_hl(a.buf) end,
        })
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
            start_hl(b) -- the buffer that triggered the lazy load gets none otherwise
        end

        -- indentation (experimental per upstream): only for filetypes with an
        -- installed parser, mapped language name (tex -> latex, bib -> bibtex, help -> vimdoc)
        local ft_to_lang = { tex = "latex", bib = "bibtex", help = "vimdoc" }
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(a)
                local ft = vim.bo[a.buf].filetype
                local lang = ft_to_lang[ft] or ft
                if pcall(vim.treesitter.language.add, lang) then
                    vim.bo[a.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
