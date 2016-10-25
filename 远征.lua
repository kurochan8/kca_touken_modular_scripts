--[[
刀_模块化脚本
远征：远征模块的本体
原作者：MaSaXX
模块化作者：sakura_candy（肝力不足），黒田くん
--]]

--刀剑乱舞自动远征脚本
--免责协议：如7X24小时使用本脚本被运营和谐封号等等请自行料理后事，虽然目前刀剑这边并没有报告会有封号情况.并且按钮点击为接近全覆盖按钮范围随机点击
--使用说明：放到KanAuto的Lua下边就可以了，推荐搭配岛风GO本地缓存最佳
--注意：请确保你系统DPI为100%缩放.
--提示：请保持KCA与TKB的版本为最新，避免造成未知错误
--更多：并没有更多...
--感谢：@爱琴炫彩 提供KCA以及部分代码以及各种帮助.
--作者：@MaSaXX

--更新日志---------------------------------------------------------------------------
--时间：2016.07.24
--Ver 0.6.0 Beta
--1.核心：重写远征回收核心代码，极大提高效率
--2.新增：出征过程中意外卡住将会自动重启游戏
--3.新增：极端情况下出现出阵错误0x010的情况下自动重启游戏并恢复远征
--4.新增：出现特殊错误自动截图并保存在KCA的screenshot目录下（以错误代码命名）
--5.新增：部分文字描述

require("API扩展")

local 通用 = require("通用")
local 取色 = require("远征_取色")
local 本丸 = 通用.本丸
local 出阵 = 通用.出阵

local 远征 = {}

function 远征.Time_ID(TimeID)
    if TimeID == 1 then
        Base.ClickRectEx(200, 190, 35, 20)
    elseif TimeID == 2 then
        Base.ClickRectEx(300, 190, 35, 20)
    elseif TimeID == 3 then
        Base.ClickRectEx(400, 190, 35, 20)
    elseif TimeID == 4 then
        Base.ClickRectEx(500, 190, 35, 20)
    elseif TimeID == 5 then
        Base.ClickRectEx(200, 190, 35, 20)
    end
end

function 远征.Point_ID(PointID)
    if PointID == 1 then
        Base.ClickRectEx(250, 290, 100, 6)
    elseif PointID == 2 then
        Base.ClickRectEx(250, 320, 100, 6)
    elseif PointID == 3 then
        Base.ClickRectEx(250, 350, 100, 6)
    elseif PointID == 4 then
        Base.ClickRectEx(250, 380, 100, 6)
    end
end

--不能在选择时代界面调用此函数(待完善
function 远征.GoToAge()
    出阵.去出阵界面()
    -- 去远征界面
    repeat
        Base.ClickRect(281, 406, 30)
        Base.Sleep(500, true)
    until 等待(取色.ExpChoice_IsColorAll)
    Win.Print("远征：进入远征界面")
end

function 远征.TeamGo(Team, Map, Point)

    -- 选择时代和目的地
    取色.Time_ID(Map)
    Base.Sleep(500, true)
    取色.Point_ID(Point)
    Base.Sleep(500, true)

    if not 取色.TeamChoiceGreen_IsColorAll() then
        Win.Print("远征：检测到" .. Map .. "-" .. Point .. "有旧的远征未完成，跳过")
        Base.Sleep(500, true)
        return 0
    end

    Base.ClickRectEx(679, 523, 70, 15)  --选择队伍
    Base.Sleep(1000)  --等待1秒

    local fail_count = 0
    while not 取色.TeamChoice_IsColorAll() do
        Win.Print("远征：没有到达队伍选择界面，等待2秒重试")
        Base.Sleep(2000)
        fail_count = fail_count + 1
        if fail_count > 2 then
            Win.Print("远征：失败超过2次，这次就不远征了")
            Base.Sleep(500, true)
            Base.ClickRect(636, 338)
            return 0
        end
    end
    --成功进入队伍选择界面

    Base.Sleep(500)   --等待0.5秒
    if Team == 4 then
        Base.ClickRectEx(231, 66, 10, 6)  --点击队伍按钮
        Base.Sleep(2000)   --等待2秒
        Base.ClickRectEx(224, 111, 8, 6)  --选择队伍4
        Base.Sleep(2000)   --等待2秒
    elseif Team == 3 then
        Base.ClickRectEx(231, 66, 10, 6)  --点击队伍按钮
        Base.Sleep(2000)   --等待2秒
        Base.ClickRectEx(231, 93, 8, 6)  --选择队伍3
        Base.Sleep(2000)   --等待2秒
    end
    --成功选择队伍

    if 取色.TeamChoiceERROR_IsColorAll() then
        Win.Print("远征：目前选择队伍正在远征中，无法选择")
        Base.Sleep(500, true)
        Base.ClickRect(561, 499)
        return 0
    end

    Base.ClickRect(694,500)  --远征开始
    Base.Sleep(7000)   --等待7秒

    Win.Print("远征：成功开始第" .. tostring(Team) .. "队远征")
    return 1
end

function 远征.执行(self)
    local 出发队伍数 = 0
    Win.Print("远征：开始执行，设定 = " .. require("inspect")(self.设定))

    本丸.等待本丸()
    远征.GoToAge()

    repeat
        Base.ClickRect(142, 187) -- 确保在第一页
        Base.Sleep(500, true)
        Base.Click(204, 188) -- 点击时代1
        Base.Sleep(500, true)
    until 等待(取色.AgeOne_IsColorAll)

    --成功进入1-4的时代界面
    for i = 1, 3, 1 do
        if self.设定.远征队伍时代[i] ~= nil then
            出发队伍数 = 出发队伍数 + 远征.TeamGo(i + 1, self.设定.远征队伍时代[i][1], self.设定.远征队伍时代[i][2])
        end
    end

    本丸.回本丸()
    Win.Print("远征：任务结束，共派出".. tostring(出发队伍数) .. "队刀剑去远征")
    return 出发队伍数
end

function 远征:new(设定)
    local instance = {}
    setmetatable(instance, {__index = 远征})
    instance.设定 = 设定
    return instance
end

setmetatable(远征, {__call = 远征.new})

return 远征
