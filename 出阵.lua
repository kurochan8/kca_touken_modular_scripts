--[[
刀_模块化脚本
出阵：改写自大家都再熟悉不过的肝图脚本
模块化作者：黒田くん
--]]

require("API扩展")

local 通用 = require("通用")
local 常量 = 通用.常量
local 本丸 = 通用.本丸
local 结成 = 通用.结成
local 出阵 = 通用.出阵

local 出阵 = {}

function 出阵.GetMode(self)
    local mode = 0
    if self.设定.战斗中遇到检非停止脚本 then
        mode = mode + 4
    end
    if self.设定.战斗中中伤停止脚本 then
        mode = mode + 1
    end
    if self.设定.战斗中轻伤停止脚本 then
        mode = mode + 2
    end
    return mode
end

function 出阵.执行(self)
    local mode = self:GetMode()
    Win.Print("出阵：开始执行，设定 = " .. require("inspect")(self.设定))

    本丸.等待本丸()

    -- 为了尽量避免碎刀惨剧检查一下队伍内是否有重伤员
    if self.设定.重伤后不停止脚本 then
        结成.去结成界面()
        结成.选择队伍(self.设定.要出击的队伍)
        local 刀血量 = {结成.检查刀血量()}

        -- 做思考状_(:3」∠)_
        Base.Sleep(1000, true)
        for i, v in ipairs(刀血量) do
            if v > 0 and v <= 常量.受伤百分比.重伤 then
                Win.Print("出阵：队伍内有重伤员，中断脚本")
                return -1
            end
        end

        Win.Print("出阵：队伍内没有重伤员，开始出阵")
        本丸.回本丸()
    end

    if not Touken.出阵(self.设定.地图[1], self.设定.地图[2], self.设定.遇到检非不进入地图) then
        Win.Print("出阵：无法出阵，退出")
        return -1
    end

    local ret = Tou.Battle(self.设定.最多进入多少次战斗点, self.设定.索敌失败后使用的阵型, mode, self.设定.要出击的队伍, self.设定.是否无视等级提示)

    if ret > 0 and not self.设定.重伤后不停止脚本 then
        Win.Print("出阵：有队员重伤，中断脚本")
        return -1
    end

    if ret == -1 then
        Win.Print("出阵：发现检非，重新进入游戏")
        Base.ReLoad()
        repeat
            Base.Click(468, 453)
        until 等待(Base.IsColor, 468, 453, 7747046)
    end

    if ret == -2 then
        Win.Print("出阵：超过等级，中断脚本")
        return -1
    end

    return ret
end

function 出阵:new(设定)
    local instance = {}
    setmetatable(instance, {__index = 出阵})
    instance.设定 = 设定
    return instance
end

setmetatable(出阵, {__call = 出阵.new})

return 出阵
