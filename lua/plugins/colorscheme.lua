return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local vscode = require("vscode")

    vscode.setup({
      transparent = false,
      style = "dark",

      group_overrides = {
 	-- ----------------------------------------------------
        -- 修复背景没有完全覆盖、露底色问题
        -- ----------------------------------------------------
        -- 1. 主编辑区 & 非激活窗口背景
        Normal = { bg = "#1E1E1E" },
        NormalNC = { bg = "#1E1E1E" },

        -- 2. 左侧行号栏 & 侧边栏（SignColumn）背景，与主窗口无缝融合
        SignColumn = { bg = "#1E1E1E" },
        LineNr = { bg = "#1E1E1E", fg = "#858585" },

        -- 3. 底部命令行 / 消息区背景，防止下方露出终端色
        MsgArea = { bg = "#1E1E1E" },
        
        -- 4. 窗口分割线颜色（消除硬分割块）
        WinSeparator = { fg = "#2B2B2B", bg = "#1E1E1E" },

        CursorLine = { bg = "#2D2D2D" },             
        Search = { bg = "#FFB86C", fg = "#000000" },

       	-- ----------------------------------------------------
        -- 1. 所有关键字 (fn, async, await, use, mod, let, mut, match 等) -> red
        -- ----------------------------------------------------
        ["@keyword"] = { fg = "#FF5555", bold = true },
        ["@keyword.type"] = { fg = "#569CD6", bold = true }, 		-- type 蓝色
        ["@keyword.function"] = { fg = "#569CD6", bold = true }, 	-- fn 蓝色
        ["@keyword.return"] = { fg = "#FF5555", bold = true }, 		-- return 红色
        ["@keyword.coroutine"] = { fg = "#FF5555", bold = true }, 	-- async/await 红色
        ["@keyword.import"] = { fg = "#FF5555", bold = true },    	-- use/mod 红色
        ["@keyword.repeat"] = { fg = "#FF5555", bold = true },    	-- loop, while
        ["@keyword.conditional"] = { fg = "#FF5555", bold = true },	-- if, else, match

        -- ----------------------------------------------------
        -- 2. 函数名 (定义的函数 & 调用的函数) -> golden yellow
        -- ----------------------------------------------------
        ["@function"] = { fg = "#FFC66D", bold = true },
        ["@function.call"] = { fg = "#FFC66D" },
	["@function.macro"] = { fg = "#9933FF" },    			-- 宏 (如 assert!, println!) 设为亮粉
	["@function.builtin"] = { fg = "#9933FF" },    			-- 宏 (如 panic!, printf) 设为亮粉

        -- ----------------------------------------------------
        -- 3. 变量名、形参、结构体成员 -> grey / soft brown 
        -- ----------------------------------------------------
        ["@variable"] = { fg = "#D4D4D4" },                      	-- 普通变量名
        ["@variable.parameter"] = { fg = "#E5C07B", italic = true }, 	-- 函数形参 (加斜体更易区分)
        ["@property"] = { fg = "#E5C07B" },                      	-- 结构体成员字段 (struct fields)
        ["@field"] = { fg = "#E5C07B" },                         	-- 兼容旧版字段高亮
      }
    })
    vscode.load()
  end,
}
