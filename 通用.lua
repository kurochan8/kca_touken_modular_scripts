--[[
刀_模块化脚本
通用：尽是一些很多界面里都通用的东西，用的时候随时载入吧
作者：黒田くん
--]]

require("API扩展")

local 通用 = {}

-- 各式常量
local 常量 = {
    刀装 = {
        种类 = {
            投石兵 = 1,
            槍兵 = 2,
            軽歩兵 = 3,
            重歩兵 = 4,
            盾兵 = 5,
            軽騎兵 = 6,
            重騎兵 = 7,
            精鋭兵 = 8,
            弓兵 = 9,
            銃兵 = 10,
        },
        质量 = {
            特上 = 100,
            上 = 200,
            並 = 300,
        },
    },
    受伤百分比 = {
        微伤 = 0.999,
        轻伤 = 0.9,
        中伤 = 0.65,
        重伤 = 0.31,
    },
    手入部屋 = {
        刀位置 = {
            {128, 80},
            {128, 157},
            {128, 234},
            {128, 311},
            {128, 388},
            {128, 465},
        },
        血条宽度 = 137,
    },
    翻页 = {
        全体位移 = {
            结成 = {320, 543},
            手入 = {316, 543},
            装备选择 = {127, 548},
        },
        控制位移 = {
            结成 = {6, 32, 235, 262},
            手入 = {6, 32, 235, 262},
            装备选择 = {6, 22, 194, 211},
        },
    },
}
通用.常量 = 常量


-- 本丸相关
local 本丸 = {}

function 本丸.在本丸()
    return Base.IsColor(53, 72, 11397105)
end

function 本丸.在信箱()
    return Base.IsColor(730, 157, 6931435)
end

function 本丸.在刀帐()
    return Base.IsColor(853, 556, 353499)
end

function 本丸.回本丸()
    repeat
        if 本丸.在信箱() then
            Base.ClickRect(770, 69, 10)
        elseif 本丸.在刀帐() then
            Base.ClickRect(859, 548, 4)
        else
            Base.ClickRectEx(900, 65, 50, 10)
        end
        Base.Sleep(500, true)
    until 等待(本丸.在本丸)
    Win.Print("通用：返回本丸")
end

function 本丸.等待本丸()
    Win.Print("通用：等待本丸")
    while true do
        if 等待(本丸.在本丸) then
            break
        end
    end
end

通用.本丸 = 本丸

-- 出阵相关
local 出阵 = {}

function 出阵.在出阵界面()
    return Base.IsColor(218, 179, 10178876)
end

function 出阵.去出阵界面()
    repeat
        Base.ClickRectEx(908, 111, 20, 8)
        Base.Sleep(500, true)
    until 等待(出阵.在出阵界面)
    Win.Print("通用：进入出阵界面")
end

通用.出阵 = 出阵

-- 结成相关
local 结成 = {}

function 结成.在结成界面()
    return Base.IsColorAll({
        {877, 143, 3750327},
        {943, 159, 526464},
    })
end

function 结成.去结成界面()
    repeat
        Base.ClickRectEx2(864, 135, 949, 165)
        Base.Sleep(500, true)
    until 等待(结成.在结成界面)
    Win.Print("通用：进入结成界面")
end

-- 如果提供n参数，返回boolean；如果不提供n参数，返回数字
function 结成.当前队伍编号(n)
    local result = 0
    if Base.IsColorAll({
        {779, 85, 13760508},
        {766, 155, 6996971},
    }) then result = 1 end
    if Base.IsColorAll({
        {779, 218, 13760508},
        {766, 291, 6996971},
    }) then result = 2 end
    if Base.IsColorAll({
        {779, 349, 13760508},
        {765, 424, 6996971},
    }) then result = 3 end
    if Base.IsColorAll({
        {779, 482, 13760508},
        {765, 555, 6996971},
    }) then result = 4 end
    if n then
        return result == n
    else
        return result
    end
end

function 结成.选择队伍(n)
    if 结成.当前队伍编号(n) then
        return
    end
    repeat
        Base.ClickRectEx2(761, -67 + 132 * n, 781, 34 + 132 * n)
        Base.Sleep(500, true)
    until 等待(结成.当前队伍编号, n)
    Win.Print("通用：切换到部队" .. tostring(n))
end

通用.结成 = 结成


-- 翻页相关
local 翻页 = {}

function 翻页.当前界面可以翻页(self)
    return Base.IsOneOfColorsAll({
        {self.overall_offsets[1], 4 + self.overall_offsets[2]},
        {self.overall_offsets[1], 10 + self.overall_offsets[2]},
    }, {
        3355443,
        5046092,
    })
end

function 翻页.在首页(self)
    return Base.IsColor(self.control_offsets[1] + self.overall_offsets[1] - 6, 7 + self.overall_offsets[2], 3355443)
end

function 翻页.在尾页(self)
    return Base.IsOneOfColors({
        self.control_offsets[4] + self.overall_offsets[1] + 6,
        7 + self.overall_offsets[2],
    }, {
        3355443,
        2763306,
    })
end

function 翻页.去上一页(self)
    Base.ClickRect(self.control_offsets[2] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function 翻页.去下一页(self)
    Base.ClickRect(self.control_offsets[3] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function 翻页.去首页(self)
    Base.ClickRect(self.control_offsets[1] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function 翻页.去尾页(self)
    Base.ClickRect(self.control_offsets[4] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function 翻页:new(overall_offsets, control_offsets)
    local instance = {}
    setmetatable(instance, {__index = 翻页})
    instance.overall_offsets = overall_offsets
    instance.control_offsets = control_offsets
    return instance
end

setmetatable(翻页, {__call = 翻页.new})

通用.翻页 = 翻页


return 通用
