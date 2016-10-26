--[[
ģ�黯��ֲ��sakura_candy���������㣩
ȡɫ���Զ��տνű�����sieben
�䷽���루ͨ�ö͵���װ��1.33��: uint 
--]]

require("API��չ")

local ͨ�� = require("ͨ��")
local ȡɫ = require("������װ_ȡɫ")

local ������װ = {}


--/**********************/
--/*      ��������      */
--/* ****************** */
--�͵�����
local EQUIP_OK = 1;
local EQUIP_TEN_OK = 10;
--�������ʹ���
local EQUIP_ERR_INVALID_ARGS_TYPE = -1;
--����ֵ����
local EQUIP_ERR_INVALID_ARGS_VALUE = -2;
--�쳣����
local EQUIP_ERR_ABNORMAL_MESSAGE_BOX = 0;
--�Ƿ��Ѿ���������䷽
local Init = false
--/**********************/
--/*     ����Ի���     */
--/* ****************** */
--/*   option:�ǻ��    */
--/* ����ť�Ի�������� */
--/*   ����ֵ:�Ƿ�ɹ�  */
--/**********************/
function ������װ.ProcessMsgbox(option)
    --����������
    time = 0;

    --��û�жԻ�����������
    if not ������װ.IsMsgbox() then
        return false;
    end

    --ѭ�����ֱ���Ի�����ʧ����ʱ60s��ÿ500ms��������һ��
    while ������װ.IsMsgbox() and time < 120 do
        --�Ƿ���"��"��ť
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
--/*�ж϶Ի����Ƿ�������*/
--/* ****************** */
--/*  ����ֵ:�Ի����Ƿ� */
--/*  ����              */
--/**********************/
function ������װ.IsMsgbox()
    return (Base.ImageHashContrast(Base.ImageHash(252,153,100,50),"007F7F7F7E7F7F7F") < 10);
end

--/**********************/
--/*�Զ�����һ����Դ��ֵ*/
--/* ****************** */
--/*operationIndex:���� */
--/*materialValue:��ֵ  */
--/* ****************** */
--/*������ֱ�ӵ��ô˺���*/
--/**********************/
function ������װ.EquipMakeInput(operationIndex, materialValue)
    --��ť���(Y��)
    buttonsSpacing = 96;
    --��λʮλ���Ӱ�ťX����
    hundredsAndTensAddButtonXPos = 719;
    --��λʮλ���ٰ�ťX����
    hundredsAndTensSubButtonXPos = 648;
    --��λ���Ӱ�ťX����
    unitsAddButtonXPos = 582;
    --��λ��ť����Y����
    hundredsButtonYPosBase = 132;
    --ʮλ��ť����Y����
    tensButtonYPosBase = 108;
    --��λ���Ӱ�ť����Y����
    unitsAddButtonYPosBase = 111;
    --��������ƫ�����ظ���
    rectPixels = 2;

    --�������
    hundredsDigit = math.floor(materialValue / 100 % 10);
    tensDigit = math.floor(materialValue / 10 % 10);
    unitsDigit = math.floor(materialValue % 10);

    --�����λ
    for i = 1, hundredsDigit do
        Base.ClickRect(hundredsAndTensAddButtonXPos, hundredsButtonYPosBase + buttonsSpacing * operationIndex, rectPixels);
        Base.Sleep(500);
    end
    --����ʮλ����ʼֵ050��˷������ۣ�
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
    --�����λ
    for i = 1, unitsDigit do
        Base.ClickRect(unitsAddButtonXPos, unitsAddButtonYPosBase + buttonsSpacing * operationIndex, rectPixels);
        Base.Sleep(500);
    end
end

--/**********************/
--/*      ��������      */
--/*    �����䷽�͵�    */
--/* ****************** */
--/*  charcoal:ľ̿��   */
--/*    steel:�����    */
--/*  coolant:��ȴ����  */
--/*  grindstone:��ʯ�� */
--/*  makeTen:�Ƿ�ʮ�� */
--/**********************/
function ������װ.EquipMakeWithRecipe(charcoal, steel, coolant, grindstone, makeTen)
    --Assumeÿ��ִ�ж��Ǵ�һ���µ�����ʼ���䷽��ʼ��һ�ξ͹���
    if not Init then
        --��鴫��Ĳ�������
        if (type(charcoal) ~= "number")
        or (type(steel) ~= "number")
        or (type(coolant) ~= "number")
        or (type(grindstone) ~= "number")
        or (type(makeTen) ~= "boolean")
        then
            Win.Print(type(charcoal)..type(steel)..type(coolant)..type(grindstone)..type(makeTen))
            return EQUIP_ERR_INVALID_ARGS_TYPE;
        end
        
        --��鴫��Ĳ�����Χ
        if ((charcoal < 50) or (charcoal > 999))
        or ((steel < 50) or (steel > 999))
        or ((coolant < 50) or (coolant > 999))
        or ((grindstone < 50) or (grindstone > 999))
        then
            return EQUIP_ERR_INVALID_ARGS_VALUE;
        end

        --����Ƿ��ڵ�װ����
        if not ȡɫ.EquipChoice_IsColorAll() then
            return EQUIP_ERR_NOT_IN_EQUIP_SCREEN;
        end

        --������ֵ����
        ������װ.EquipMakeInput(0, charcoal);
        ������װ.EquipMakeInput(1, steel);
        ������װ.EquipMakeInput(2, coolant);
        ������װ.EquipMakeInput(3, grindstone);
        Init = true
    end

    --�㰴��װ������ʼ
    if makeTen then
        Base.ClickRectEx(440,507);
    else
        Base.ClickRectEx(639,506)
    end
    Base.Sleep(800);

    --�����Ի��򣬿���������ʲô��
    if ������װ.IsMsgbox() then
		������װ.ProcessMsgbox(false);
        return EQUIP_ERR_ABNORMAL_MESSAGE_BOX;
    end
    
    if makeTen then
        return EQUIP_TEN_OK
    end
    return EQUIP_OK
end

function ������װ.ִ��(self)
    ͨ��.����.�ر���()
    local returncode = 1
    local Num = 0
    Win.Print("������װ����ʼִ�У��趨 = " .. require("inspect")(self.�趨))

    Base.Click(910,232)
	Base.Sleep(2000)
	while ȡɫ.EquipChoice_IsColorAll() == false do
	    	Win.Print("δ�ܳɹ����뵶װ���棬�ȴ�3������")
            Base.Sleep(3000) 
    end
    
    --����ʮ��,Ȼ��һ��һ����
    local makeTen = true
    while returncode > 0 do
        returncode = ������װ.EquipMakeWithRecipe(self.�趨.ľ̿, self.�趨.���, self.�趨.��ȴ, self.�趨.��ʯ, makeTen)
        if returncode < 0 then
            return returncode
        end
        Num = Num + returncode

        if returncode == 0 and makeTen then
            makeTen = false
            returncode = 1        
        end
    end
    Win.Print("������װ"..Num.."��")
    ͨ��.����.�ر���()
    return Num
end

function ������װ:new(�趨)
    local instance = {}
    setmetatable(instance, {__index = ������װ})
    instance.�趨 = �趨
    return instance
end

setmetatable(������װ, {__call = ������װ.new})

return ������װ