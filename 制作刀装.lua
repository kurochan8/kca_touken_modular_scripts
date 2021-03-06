--[[
模块制作：sakura_candy（肝力不足）
配方输入（通用锻刀封装库1.33）: uint
--]]

require("API扩展")

local 通用 = require("通用")
local 取色 = require("制作刀装_取色")

local 制作刀装 = {}


--/**********************/
--/*      常量定义      */
--/* ****************** */
--锻刀正常
local EQUIP_OK = 1
local EQUIP_TEN_OK = 10
--参数类型错误
local EQUIP_ERR_INVALID_ARGS_TYPE = -1
--参数值错误
local EQUIP_ERR_INVALID_ARGS_VALUE = -2
--异常弹窗
local EQUIP_ERR_ABNORMAL_MESSAGE_BOX = 0
--是否已经输入好了配方
local Init = false
--/**********************/
--/*     处理对话框     */
--/* ****************** */
--/*   option:是或否    */
--/* 单按钮对话框可任意 */
--/*   返回值:是否成功  */
--/**********************/
function 制作刀装.ProcessMsgbox(option)
    --操作计数器
    local time = 0

    --并没有对话框，立即返回
    if not 制作刀装.IsMsgbox() then
        return false
    end

    --循环点击直到对话框消失，限时60s（每500ms计数器加一）
    while 制作刀装.IsMsgbox() and time < 120 do
        --是否有"否"按钮
        if Base.ImageHashContrast(Base.ImageHash(536, 324, 80, 30), "FFFFFB7F7B4B0100") < 10 then
                if option then
                    Base.ClickRect(386, 338)
                else
                    Base.ClickRect(571, 338)
                end
        else
            Base.ClickRect(486, 338)
        end
        Base.Sleep(500)
        time = time + 1
    end

    if time < 120 then
        return true
    else
        return false
    end
end

--/**********************/
--/*判断对话框是否正弹出*/
--/* ****************** */
--/*  返回值:对话框是否 */
--/*  弹出              */
--/**********************/
function 制作刀装.IsMsgbox()
    return (Base.ImageHashContrast(Base.ImageHash(252, 153, 100, 50), "007F7F7F7E7F7F7F") < 10)
end

--/**********************/
--/*自动输入一种资源的值*/
--/* ****************** */
--/*operationIndex:类型 */
--/*materialValue:数值  */
--/* ****************** */
--/*不建议直接调用此函数*/
--/**********************/
function 制作刀装.EquipMakeInput(operationIndex, materialValue)
    --按钮间距(Y轴)
    local buttonsSpacing = 96
    --百位十位增加按钮X坐标
    local hundredsAndTensAddButtonXPos = 719
    --百位十位减少按钮X坐标
    local hundredsAndTensSubButtonXPos = 648
    --个位增加按钮X坐标
    local unitsAddButtonXPos = 582
    --百位按钮基础Y坐标
    local hundredsButtonYPosBase = 132
    --十位按钮基础Y坐标
    local tensButtonYPosBase = 108
    --个位增加按钮基础Y坐标
    local unitsAddButtonYPosBase = 111
    --单击区域偏移像素个数
    local rectPixels = 2

    --拆分数字
    local hundredsDigit = math.floor(materialValue / 100 % 10)
    local tensDigit = math.floor(materialValue / 10 % 10)
    local unitsDigit = math.floor(materialValue % 10)

    --输入百位
    for i = 1, hundredsDigit do
        Base.ClickRect(hundredsAndTensAddButtonXPos, hundredsButtonYPosBase + buttonsSpacing * operationIndex, rectPixels)
        Base.Sleep(500)
    end
    --输入十位（初始值050因此分类讨论）
    if tensDigit > 5 then
        for i = 1, (tensDigit - 5) do
            Base.ClickRect(hundredsAndTensAddButtonXPos, tensButtonYPosBase + buttonsSpacing * operationIndex, rectPixels)
            Base.Sleep(500)
        end
    else
        for i = 1, (5 - tensDigit) do
            Base.ClickRect(hundredsAndTensSubButtonXPos, tensButtonYPosBase + buttonsSpacing * operationIndex, rectPixels)
            Base.Sleep(500)
        end
    end
    --输入个位
    for i = 1, unitsDigit do
        Base.ClickRect(unitsAddButtonXPos, unitsAddButtonYPosBase + buttonsSpacing * operationIndex, rectPixels)
        Base.Sleep(500)
    end
end

--/**********************/
--/*      公开函数      */
--/*    按照配方锻刀    */
--/* ****************** */
--/*  charcoal:木炭数   */
--/*    steel:玉钢数    */
--/*  coolant:冷却材数  */
--/*  grindstone:砥石数 */
--/*  makeTen:是否十连 */
--/**********************/
function 制作刀装.EquipMakeWithRecipe(charcoal, steel, coolant, grindstone, makeTen)
    --Assume每次执行都是从一个新的任务开始，配方初始化一次就够了

    if not Init then
        --检查传入的参数类型
        if (type(charcoal) ~= "number")
        or (type(steel) ~= "number")
        or (type(coolant) ~= "number")
        or (type(grindstone) ~= "number")
        or (type(makeTen) ~= "boolean")
        then
            Win.Print(type(charcoal)..type(steel)..type(coolant)..type(grindstone)..type(makeTen))
            return EQUIP_ERR_INVALID_ARGS_TYPE
        end

        --检查传入的参数范围
        if ((charcoal < 50) or (charcoal > 999))
        or ((steel < 50) or (steel > 999))
        or ((coolant < 50) or (coolant > 999))
        or ((grindstone < 50) or (grindstone > 999))
        then
            return EQUIP_ERR_INVALID_ARGS_VALUE
        end

        --按照数值输入
        制作刀装.EquipMakeInput(0, charcoal)
        制作刀装.EquipMakeInput(1, steel)
        制作刀装.EquipMakeInput(2, coolant)
        制作刀装.EquipMakeInput(3, grindstone)
        Init = true
    end

    --点按刀装制作开始
    if makeTen then
        Base.ClickRectEx(440, 507)
    else
        Base.ClickRectEx(639, 506)
    end
    Base.Sleep(1000)

    --弹出对话框，可能是满了什么的
    if 制作刀装.IsMsgbox() then
        制作刀装.ProcessMsgbox(false)
        return EQUIP_ERR_ABNORMAL_MESSAGE_BOX
    end

    取色.等待刀装制作完毕()

    if makeTen then
        return EQUIP_TEN_OK
    end
    return EQUIP_OK
end

function 制作刀装.执行(self)
    通用.本丸.回本丸()
    local returncode = 1
    local Num = 0
    Init = false
    Win.Print("制作刀装：开始执行，设定 = " .. require("inspect")(self.设定))

    --取色.等待刀装制作画面()
    while not 取色.刀装作成画面() do
        Base.Click(910, 232)
        Base.Sleep(2000)
    end
    Win.Print("制作刀装：进入界面")
    --先试十连,然后一个一个做
    local makeTen = true
    while returncode > 0 do
        returncode = 制作刀装.EquipMakeWithRecipe(self.设定.木炭, self.设定.玉钢, self.设定.冷却, self.设定.砥石, makeTen)
        if returncode < 0 then
            return returncode
        end
        Num = Num + returncode

        if returncode == 0 and makeTen then
            makeTen = false
            returncode = 1
        end
    end
    Win.Print("制作刀装：共" .. tostring(Num) .. "个")
    通用.本丸.回本丸()
    return Num
end

function 制作刀装:new(设定)
    local instance = {}
    setmetatable(instance, {__index = 制作刀装})
    instance.设定 = 设定
    return instance
end

setmetatable(制作刀装, {__call = 制作刀装.new})

return 制作刀装
