--[[
模块化移植：sakura_candy（肝力不足）
取色（自动日课脚本）：sieben
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
local EQUIP_OK = 1;
local EQUIP_TEN_OK = 10;
--参数类型错误
local EQUIP_ERR_INVALID_ARGS_TYPE = -1;
--参数值错误
local EQUIP_ERR_INVALID_ARGS_VALUE = -2;
--异常弹窗
local EQUIP_ERR_ABNORMAL_MESSAGE_BOX = 0;
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
    time = 0;

    --并没有对话框，立即返回
    if not 制作刀装.IsMsgbox() then
        return false;
    end

    --循环点击直到对话框消失，限时60s（每500ms计数器加一）
    while 制作刀装.IsMsgbox() and time < 120 do
        --是否有"否"按钮
        if Base.ImageHashContrast(Base.ImageHash(536,324,80,30),"FFFFFB7F7B4B0100") < 10 then
                if option then
                    Base.ClickRect(386,338);
                else
                    Base.ClickRect(571,338);
                end
        else
            Base.ClickRect(486,338);
        end
        Base.Sleep(500);
        time = time + 1;
    end

    if time < 120 then
        return true;
    else
        return false;
    end
end

--/**********************/
--/*判断对话框是否正弹出*/
--/* ****************** */
--/*  返回值:对话框是否 */
--/*  弹出              */
--/**********************/
function 制作刀装.IsMsgbox()
    return (Base.ImageHashContrast(Base.ImageHash(252,153,100,50),"007F7F7F7E7F7F7F") < 10);
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
    buttonsSpacing = 96;
    --百位十位增加按钮X坐标
    hundredsAndTensAddButtonXPos = 719;
    --百位十位减少按钮X坐标
    hundredsAndTensSubButtonXPos = 648;
    --个位增加按钮X坐标
    unitsAddButtonXPos = 582;
    --百位按钮基础Y坐标
    hundredsButtonYPosBase = 132;
    --十位按钮基础Y坐标
    tensButtonYPosBase = 108;
    --个位增加按钮基础Y坐标
    unitsAddButtonYPosBase = 111;
    --单击区域偏移像素个数
    rectPixels = 2;

    --拆分数字
    hundredsDigit = math.floor(materialValue / 100 % 10);
    tensDigit = math.floor(materialValue / 10 % 10);
    unitsDigit = math.floor(materialValue % 10);

    --输入百位
    for i = 1, hundredsDigit do
        Base.ClickRect(hundredsAndTensAddButtonXPos, hundredsButtonYPosBase + buttonsSpacing * operationIndex, rectPixels);
        Base.Sleep(500);
    end
    --输入十位（初始值050因此分类讨论）
    if tensDigit > 5 then
        for i = 1, (tensDigit - 5) do
            Base.ClickRect(hundredsAndTensAddButtonXPos, tensButtonYPosBase + buttonsSpacing * operationIndex, rectPixels);
            Base.Sleep(500);
        end
    else
        for i = 1, (5 - tensDigit) do
            Base.ClickRect(hundredsAndTensSubButtonXPos, tensButtonYPosBase + buttonsSpacing * operationIndex, rectPixels);
            Base.Sleep(500);
        end
    end
    --输入个位
    for i = 1, unitsDigit do
        Base.ClickRect(unitsAddButtonXPos, unitsAddButtonYPosBase + buttonsSpacing * operationIndex, rectPixels);
        Base.Sleep(500);
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
            return EQUIP_ERR_INVALID_ARGS_TYPE;
        end
        
        --检查传入的参数范围
        if ((charcoal < 50) or (charcoal > 999))
        or ((steel < 50) or (steel > 999))
        or ((coolant < 50) or (coolant > 999))
        or ((grindstone < 50) or (grindstone > 999))
        then
            return EQUIP_ERR_INVALID_ARGS_VALUE;
        end

        --检查是否在刀装制作
        if not 取色.EquipChoice_IsColorAll() then
            return EQUIP_ERR_NOT_IN_EQUIP_SCREEN;
        end

        --按照数值输入
        制作刀装.EquipMakeInput(0, charcoal);
        制作刀装.EquipMakeInput(1, steel);
        制作刀装.EquipMakeInput(2, coolant);
        制作刀装.EquipMakeInput(3, grindstone);
        Init = true
    end

    --点按刀装制作开始
    if makeTen then
        Base.ClickRectEx(440,507);
    else
        Base.ClickRectEx(639,506)
    end
    Base.Sleep(800);

    --弹出对话框，可能是满了什么的
    if 制作刀装.IsMsgbox() then
		制作刀装.ProcessMsgbox(false);
        return EQUIP_ERR_ABNORMAL_MESSAGE_BOX;
    end
    
    if makeTen then
        return EQUIP_TEN_OK
    end
    return EQUIP_OK
end

function 制作刀装.执行(self)
    通用.本丸.回本丸()
    local returncode = 1
    local Num = 0
    Win.Print("制作刀装：开始执行，设定 = " .. require("inspect")(self.设定))

    Base.Click(910,232)
	Base.Sleep(2000)
	while 取色.EquipChoice_IsColorAll() == false do
	    	Win.Print("未能成功进入刀装界面，等待3秒重试")
            Base.Sleep(3000) 
    end
    
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
    Win.Print("制作刀装"..Num.."个")
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