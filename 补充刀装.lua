--[[
刀_模块化脚本 v0.1 by 群内@黒田くん
补充刀装_取色：补充刀装模块取色部分，就是一堆
--]]

require("API扩展")

local 通用 = require("通用")
local 常量 = 通用.常量
local 本丸 = 通用.本丸
local 结成 = 通用.结成
local 翻页 = 通用.翻页(常量.翻页.全体位移.装备选择, 常量.翻页.控制位移.装备选择)
local 取色 = require("补充刀装_取色")

local 补充刀装 = {}

local 预设策略 = {
    远战 = {
        {"投石兵", "並"}, {"銃兵", "並"}, {"弓兵", "並"},
        {"投石兵", "上"}, {"銃兵", "上"}, {"弓兵", "上"},
        {"投石兵", "特上"}, {"銃兵", "特上"}, {"弓兵", "特上"},
    },
    金银远战 = {
        {"投石兵", "上"}, {"銃兵", "上"}, {"弓兵", "上"},
        {"投石兵", "特上"}, {"銃兵", "特上"}, {"弓兵", "特上"},
    },
    金远战 = {
        {"投石兵", "特上"}, {"銃兵", "特上"}, {"弓兵", "特上"},
    },
    投石 = {
        {"投石兵", "並"}, {"投石兵", "上"}, {"投石兵", "特上"},
    },
    金银投石 = {
        {"投石兵", "上"}, {"投石兵", "特上"},
    },
    金投石 = {
        {"投石兵", "特上"},
    },
    金盾 = {
        {"盾兵", "特上"},
    },
    金银轻骑 = {
        {"軽騎兵", "上"}, {"軽騎兵", "特上"},
    },
    金轻骑 = {
        {"軽騎兵", "特上"},
    },
    轻步 = {
        {"軽歩兵", "並"}, {"軽歩兵", "上"}, {"軽歩兵", "特上"},
    },
    金银轻步 = {
        {"軽歩兵", "上"}, {"軽歩兵", "特上"},
    },
    金轻步 = {
        {"軽歩兵", "特上"},
    },
}

function 补充刀装.去装备变更界面(self, n)
    repeat
        Base.ClickRectEx2(712, 51 + n * 77, 746, 68 + n * 77)
        Base.Sleep(500, true)
    until 等待(取色.在装备变更界面)
    Win.Print("补充刀装：补充" .. tostring(n) .. "号队员的刀装")
end

function 补充刀装.退出装备变更界面(self)
    repeat
        Base.ClickRectEx2(127, 59, 341, 558)
        Base.Sleep(500, true)
    until 等待(结成.在结成界面)
end

function 补充刀装.打开装备选择界面(self, n)
    repeat
        Base.ClickRectEx2(534, 139 + n * 38, 552, 157 + n * 38)
        Base.Sleep(500, true)
    until 等待(取色.装备选择界面已打开)
    Win.Print("补充刀装：补充" .. tostring(n) .. "号位的刀装")
end

function 补充刀装.选择刀装(self, n)
    repeat
        Base.ClickRectEx2(128, 3 + n * 78, 340, 71 + n * 78)
        Base.Sleep(500, true)
    until 等待(取色.已选择刀装, n)
end

function 补充刀装.装备刀装(self, n, i)
    repeat
        Base.ClickRectEx2(300, 11 + n * 78, 334, 28 + n * 78)
        Base.Sleep(500, true)
    until 等待(取色.已装备刀装, i)
end

local function 刀装ID到全名(id)
    return table.key_of(常量.刀装.种类, id % 100) .. "." .. table.key_of(常量.刀装.质量, math.floor(id / 100) * 100)
end

-- TODO: 需要测试完全没有可装备刀装的edge case，哪位好心人帮帮忙~
function 补充刀装.执行(self)
    local 总补充刀装数 = 0
    -- 替换预设策略
    for i = 1, 6, 1 do
        if type(self.设定[i].策略) == "string" then
            if not 预设策略[self.设定[i].策略] then
                Win.Print("补充刀装：预设策略\"" .. self.设定[i].策略 .."\"不存在！请检查你的设定")
                本丸.回本丸()
                return 总补充刀装数
            end
            self.设定[i].策略 = 预设策略[self.设定[i].策略]
        end
    end
    Win.Print("补充刀装：开始执行，设定 = " .. require("inspect")(self.设定))

    本丸.等待本丸()
    结成.去结成界面()
    结成.选择队伍(self.设定.部队号)

    local 刀装状态 = 取色.检查刀装状态()
    local 需要补充的刀装位 = {{}, {}, {}, {}, {}, {}}
    for i = 1, 6, 1 do
        for j = 1, 3, 1 do
            if 刀装状态[i][j] then
                table.insert(需要补充的刀装位[i], j)
            end
        end
    end

    for i = 1, 6, 1 do
        if #需要补充的刀装位[i] > 0 then

            -- 做思考状_(:3」∠)_
            Base.Sleep(1000, true)

            self:去装备变更界面(i)

            for key, j in ipairs(需要补充的刀装位[i]) do
                self:打开装备选择界面(j)

                local 当前页码 = 1
                local 策略 = table.map(self.设定[i].策略, function (s)
                    return 常量.刀装.种类[s[1]] + 常量.刀装.质量[s[2]]
                end)
                local 已发现的刀装 = {}
                local 要补充的刀装 = nil
                while not 要补充的刀装 do

                    local 当前页面刀装 = 取色.取得当前页面刀装()
                    for index, id in ipairs(当前页面刀装) do
                        if table.index_of(策略, id) ~= 0 then
                            已发现的刀装[id] = {
                                ID = id,
                                页码 = 当前页码,
                                位置 = index,
                            }
                        end
                    end

                    -- 清理掉没找到以后也不可能找到的刀装
                    while not 已发现的刀装[策略[1]] and 策略[1] <= 当前页面刀装[#当前页面刀装] do
                        table.remove(策略, 1)
                    end

                    -- 看看是否已找到最合适的刀装
                    if 已发现的刀装[策略[1]] then
                        要补充的刀装 = 已发现的刀装[策略[1]]
                        break
                    end

                    -- 检查是否已经在尾页
                    if 翻页:在尾页() then
                        break
                    end

                    -- 去下一页
                    翻页:去下一页()
                    当前页码 = 当前页码 + 1
                end

                -- 已排查完所有刀装，使用有库存并且优先级最高的刀装
                if not 要补充的刀装 then
                    for k = 1, #策略, 1 do
                        if 已发现的刀装[策略[k]] then
                            要补充的刀装 = 已发现的刀装[策略[k]]
                            break
                        end
                    end
                end

                -- 如果最终还是什么都没找到_(:3」∠)_
                if not 要补充的刀装 then
                    if self.设定[i].允许补充任意刀装 then
                        要补充的刀装 = {
                            ID = 取色.取得刀装(1),
                            页码 = 当前页码,
                            位置 = 1,
                        }
                        Win.Print("补充刀装：未找到符合条件的刀装，尝试装备任意刀装")
                    else
                        Win.Print("补充刀装：找不到可用刀装，任务失败")
                        本丸.回本丸()
                        return 总补充刀装数
                    end
                end

                -- 去装备要补充的刀装
                while 当前页码 ~= 要补充的刀装.页码 do
                    -- 当前页码只可能比要补充的刀装的页码大
                    翻页:去上一页()
                    当前页码 = 当前页码 - 1
                end

                self:选择刀装(要补充的刀装.位置)
                self:装备刀装(要补充的刀装.位置, j)
                总补充刀装数 = 总补充刀装数 + 1
                Win.Print("补充刀装：装备了一个" .. 刀装ID到全名(要补充的刀装.ID))
            end

            self:退出装备变更界面()
        end
    end

    本丸.回本丸()
    Win.Print("补充刀装：任务结束，共补充" .. tostring(总补充刀装数) .. "个刀装")
    return 总补充刀装数
end

function 补充刀装:new(设定)
    local instance = {}
    setmetatable(instance, {__index = 补充刀装})
    instance.设定 = 设定
    return instance
end

setmetatable(补充刀装, {__call = 补充刀装.new})

return 补充刀装
