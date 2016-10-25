--[[
模块化移植：sakura_candy（肝力不足）
远征_取色：MaSaXX
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

local 远征 = {}

local Num = 0

------------------------------------------------------------------------------------

function 远征.Init()      --初始化函数

    while 取色.SwordList_IsColorAll() == true do
        Base.ClickRect(859,548,4)  --回本丸
        Base.Sleep(500)
     end

    while 取色.Mail_IsColorAll() == true do
        Base.ClickRect(770,69,10)  --回本丸
        Base.Sleep(500)
     end

    Base.ClickRectEx(900,65,50,10)  --初始化回本丸
    Base.Sleep(1000)  --等待1秒


    通用.本丸.回本丸()
    --成功进入本丸界面

    Win.Print("初始化：处理数据中，请稍候...")
   -- Win.SetState("初始化完成，等待队伍检测阶段...")
end

function 远征.GoToAge()      --不能在选择时代界面调用此函数(待完善

    Base.ClickRectEx(908,111,20,8)  --出阵
    Base.Sleep(1500)  --等待1秒
     while 取色.Attack_IsColorAll() == false do
        Win.Print("错误代码:0x010 未能进入出阵界面，等待2秒重试，若一直提示请游戏+KCA截图")
        Base.Sleep(2000)
        Base.ClickRectEx(908,111,20,8)  --重新点击出阵
    end
    --成功进入出阵界面

    Base.ClickRect(281,406,30)  --远征
    Base.Sleep(2000)  --等待2秒

    while 取色.ExpChoice_IsColorAll() == false do
        Win.Print("错误代码:0x004 没有到达远征择界面，等待2秒重试")
        Base.Sleep(2000)
    end
    --成功进入远征界面
end

function 远征.TeamGo(Team, Map, Point)
    while 取色.AgeOne_IsColorAll() == false do
        Win.Print("错误代码:0x005B 没有回到1-4的时代界面，等待3秒重试")
        Base.Sleep(8000)
        取色.Time_ID(Point)
    end

    取色.Time_ID(Map)
    Base.Sleep(800)
    取色.Point_ID(Point)
    Base.Sleep(800)

    if 取色.TeamChoiceGreen_IsColorAll() == false then
        Win.Print("初始化：检测到" .. Map .. "-" .. Point .. "有旧的远征未完成，跳过")
        Base.Sleep(1000)
        return
    end

    Base.ClickRectEx(679,523,70,15)  --选择队伍
    Base.Sleep(1000)  --等待1秒

    fail_count = 0
    while 取色.TeamChoice_IsColorAll() == false do
        Win.Print("没有到达队伍选择界面，等待2秒重试")
        Base.Sleep(2000)
        fail_count = fail_count+1
        if fail_count > 2 then
            Win.Print("失败超过2次，这次就不远征了")
            Base.ClickRect(636,338)
            return
        end
    end
    --成功进入队伍选择界面

    Base.Sleep(500)   --等待0.5秒
    if Team == 4 then
        Base.ClickRectEx(231,66,10,6)  --点击队伍按钮
        Base.Sleep(2000)   --等待2秒
        Base.ClickRectEx(224,111,8,6)  --选择队伍4
        Base.Sleep(2000)   --等待2秒
    elseif Team == 3 then
        Base.ClickRectEx(231,66,10,6)  --点击队伍按钮
        Base.Sleep(2000)   --等待2秒
        Base.ClickRectEx(231,93,8,6)  --选择队伍3
        Base.Sleep(2000)   --等待2秒
    end

    while 取色.TeamChoiceERROR_IsColorAll() == true do
        Win.Print("目前选择队伍正在远征中，无法选择")
        Base.Sleep(800)
        Base.ClickRect(561,499)
        return
    end
    --成功选择队伍

    Base.ClickRect(694,500)  --远征开始
    Base.Sleep(7000)   --等待7秒
    Win.Print("提示：成功开始第"..Team.."队远征")
    Num = Num + 1

end

function 远征.执行(self)
    Win.Print("远征：开始执行，设定 = " .. require("inspect")(self.设定))

    远征.Init()
    Win.Print("初始化：完成，进入下一阶段...")
    远征.GoToAge()
    Base.ClickRect(142,187)  --确保在第一页
        while 取色.AgeOne_IsColorAll() == false do
            Win.Print("错误代码:0x005 没有到1-4的时代界面，等待2秒重试")
            Base.Sleep(2000)
        end
        Base.Sleep(200)
        Base.Click(204,188) --点击时代1
        Base.Sleep(200)
        --成功进入1-4的时代界面
        if self.设定.远征队伍时代[1] ~= nil then
            远征.TeamGo(2, self.设定.远征队伍时代[1][1], self.设定.远征队伍时代[1][2])
        end
        if self.设定.远征队伍时代[2] ~= nil then
            远征.TeamGo(3, self.设定.远征队伍时代[2][1], self.设定.远征队伍时代[2][2])
        end
        if self.设定.远征队伍时代[3] ~= nil then
            远征.TeamGo(4, self.设定.远征队伍时代[3][1], self.设定.远征队伍时代[3][2])
        end

        通用.本丸.回本丸()
        Win.Print("远征：任务结束")
        return Num
end

function 远征:new(设定)
    local instance = {}
    setmetatable(instance, {__index = 远征})
    instance.设定 = 设定
    return instance
end

setmetatable(远征, {__call = 远征.new})

return 远征