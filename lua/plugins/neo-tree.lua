return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = false,
            window = {
                position = "left",
                width = 25,
                mappings = {
                    -- jump
                    -- ["]"] = "next_sibling",     -- 跳转到同层级的下一个文件/文件夹
                    -- ["["] = "prev_sibling",     -- 跳转到同层级的上一个文件/文件夹
                    -- ["J"] = "last_sibling",     -- 快速跳转到同层级的【最后一个】
                    -- ["K"] = "first_sibling",    -- 快速跳转到同层级的【第一个】

                    -- filter / find
                    ["/"] = "fuzzy_finder",         -- 模糊搜索过滤（只在 neo-tree 树内，实时高亮匹配）
                    ["f"] = "filter_on_submit",     -- 按 Enter 确认搜索过滤内容

                    -- fold / unfold
                    ["zM"] = "close_all_nodes",     -- 全部折叠
                    ["zR"] = "expand_all_nodes",    -- 全部展开

                    -- change nvim root directory
                    ["."] = "set_root",             -- 将光标下的文件夹设为临时根目录
                    ["u"] = "navigate_up",          -- 向上返回上一层根目录

                    -- splite
                    ["N"] = "open_split",           -- horizental splite
                    ["n"] = "open_vsplit",          -- vertical splite
                },
            },

            -- file system settings
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                },
            },
        })

        -- neo-tree switch
        vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle left<CR>", { desc = "Toggle NeoTree" })
    end,
}
