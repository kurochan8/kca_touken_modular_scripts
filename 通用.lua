--[[
刀_模块化脚本 v0.1 by 群内@黒田くん
通用： 尽是一些很多界面里都通用的东西，用的时候随时载入吧
--]]

require("API扩展")

local 通用 = {}

-- 翻页相关
-- 结成： 320, 543
-- 手入： 316, 543

local 翻页 = {}

function 翻页.当前界面可以翻页(self)
    return Base.IsOneOfColorsAll({
        {0 + self.x_offset, 7 + self.y_offset},
        {268 + self.x_offset, 7 + self.y_offset},
    }, {
        3355443,
        5046092,
    })
end

function 翻页.已在首页(self)
    return Base.IsColor(0 + self.x_offset, 7 + self.y_offset, 3355443)
end

function 翻页.已在尾页(self)
    return Base.IsColor(268 + self.x_offset, 7 + self.y_offset, 3355443)
end

function 翻页.去上一页(self)
    Base.ClickRect(32 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function 翻页.去下一页(self)
    Base.ClickRect(235 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function 翻页.去首页(self)
    Base.ClickRect(6 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function 翻页.去尾页(self)
    Base.ClickRect(262 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function 翻页:new(x_offset, y_offset)
    local instance = {}
    setmetatable(instance, {__index = 翻页})
    instance.x_offset = x_offset
    instance.y_offset = y_offset
    return instance
end

setmetatable(翻页, {__call = 翻页.new})

通用.翻页 = 翻页

return 通用
