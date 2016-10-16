--[[
刀_模块化脚本 v0.1 by 群内@黒田くん
手入：部分基于手入脚本v1.3，感谢论坛@sakura_candy，群内@肝力不足
--]]

require("API扩展")

local 通用 = require("通用")
local 常量 = 通用.常量
local 本丸 = 通用.本丸
local 翻页 = 通用.翻页(常量.翻页.全体位移.手入, 常量.翻页.控制位移.手入)
local 取色 = require("手入_取色")

local 手入 = {}

function 手入.进入主界面(self)
    repeat
        Base.ClickRectEx(907, 270, 80, 30)
        Base.Sleep(500, true)
    until 等待(取色.在主界面内)
    Win.Print("手入：进入手入画面")
end

function 手入.进入手入部屋(self, n)
    repeat
        Base.ClickRectEx(451, 136 + (n - 1) * 121, 600, 80)
        Base.Sleep(500, true)
    until 等待(取色.在手入部屋内)
    Win.Print("手入：进入" .. tostring(n) .. "号手入部屋")
end

function 手入.选择刀(self, n)
    repeat
        Base.ClickRectEx(454, 118 + (n - 1) * 77, 20, 20)
        Base.Sleep(500, true)
    until 等待(取色.已选刀)
    Win.Print("手入：选中当前页面第" .. tostring(n) .. "把刀")
end

function 手入.使用加速(self)
    Base.ClickRectEx(670, 392, 100, 8)
    Base.Sleep(500)
    Base.ClickRectEx(670, 413, 100, 8)
    Base.Sleep(500)
    Win.Print("手入：使用加速")
end

function 手入.开始手入(self)
    repeat
        Base.ClickRectEx(635, 490, 150, 30)
        Base.Sleep(500)
    until 等待(取色.在主界面内)
    Win.Print("手入：开始手入")
end

function 手入.执行(self)
    local 总治疗刀数 = 0
    Win.Print("手入：开始执行，设定 = " .. require("inspect")(self.设定))

    本丸.等待本丸()

    self:进入主界面()

    while true do
        等待(取色.在主界面内)

        -- 做思考状_(:3」∠)_
        Base.Sleep(1000, true)

        local 手入部屋状态 = {取色.检查手入部屋状态()}
        for i, v in ipairs(self.设定.可用部屋) do
            手入部屋状态[i] = 手入部屋状态[i] and v
        end

        local 使用这间手入部屋 = table.index_of(手入部屋状态, true)
        if 使用这间手入部屋 == 0 then
            break
        end

        self:进入手入部屋(使用这间手入部屋)
        Win.Print("手入：开始检查刀剑状态")

        local 当前页码 = 1
        local 需要手入的刀剑 = {}

        while true do

            -- 做思考状_(:3」∠)_
            Base.Sleep(1000, true)

            local 扫描完毕 = false
            local 当前页面刀剑血量 = {取色.检查刀血量()}
            local 当前页面刀剑手入状态 = {取色.检查刀是否已在手入()}

            for 当前位置, 当前血量 in ipairs(当前页面刀剑血量) do

                if 当前血量 == 1 then
                    扫描完毕 = true
                    break
                end

                if not 当前页面刀剑手入状态[当前位置] and 当前血量 <= 常量.受伤百分比[self.设定.手入受伤等级] then
                    table.insert(需要手入的刀剑, {
                        页码 = 当前页码,
                        位置 = 当前位置,
                        血量 = 当前血量,
                    })
                end
            end

            if 扫描完毕 or not self.设定.优先治疗高受伤等级 and #需要手入的刀剑 > 0 or 翻页:在尾页() then
                break
            end

            翻页:去下一页()
            当前页码 = 当前页码 + 1
        end

        if #需要手入的刀剑 == 0 then
            break
        end

        if self.设定.优先治疗高受伤等级 then
            table.sort(需要手入的刀剑, function (a, b) return a.血量 < b.血量 end)
        end

        local 要执行手入的刀 = 需要手入的刀剑[1]
        Win.Print("手入：已找到需要治疗的刀剑")

        if 要执行手入的刀.页码 > 1 then
            翻页:去首页()
            for i = 1, 要执行手入的刀.页码 - 1, 1 do
                翻页:去下一页()
            end
        end

        self:选择刀(要执行手入的刀.位置)
        等待(取色.已选刀)

        if not 取色.已选刀可手入() then
            Win.Print("手入：脚本出现异常")
            return 0
        end

        if self.设定.使用加速受伤等级 and 要执行手入的刀.血量 <= 常量.受伤百分比[self.设定.使用加速受伤等级] then
            self:使用加速()
        end

        总治疗刀数 = 总治疗刀数 + 1
        self:开始手入()
    end

    本丸.回本丸()
    Win.Print("手入：任务结束，共治疗" .. tostring(总治疗刀数) .. "把刀")
    return 总治疗刀数
end

function 手入:new(设定)
    local instance = {}
    setmetatable(instance, {__index = 手入})
    instance.设定 = 设定
    return instance
end

setmetatable(手入, {__call = 手入.new})

return 手入
