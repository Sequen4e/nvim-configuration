return {
    'numToStr/Comment.nvim',
    opts = {
        -- gc / gb
        padding = true,   -- 注释符号与代码之间自动加空格
        sticky = true,    -- 注释后光标保持在原位置
        ignore = nil,     -- 忽略空行
    },
    config = function(_, opts)
        require('Comment').setup(opts)
    end,
}
