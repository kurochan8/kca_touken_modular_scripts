--[[
��_ģ�黯�ű�
Զ����Զ��ģ��ı���
ԭ���ߣ�MaSaXX
ģ�黯���ߣ�sakura_candy���������㣩���\�勞��
--]]

--���������Զ�Զ���ű�
--����Э�飺��7X24Сʱʹ�ñ��ű�����Ӫ��г��ŵȵ�������������£���ȻĿǰ������߲�û�б�����з�����.���Ұ�ť���Ϊ�ӽ�ȫ���ǰ�ť��Χ������
--ʹ��˵�����ŵ�KanAuto��Lua�±߾Ϳ����ˣ��Ƽ����䵺��GO���ػ������
--ע�⣺��ȷ����ϵͳDPIΪ100%����.
--��ʾ���뱣��KCA��TKB�İ汾Ϊ���£��������δ֪����
--���ࣺ��û�и���...
--��л��@�����Ų� �ṩKCA�Լ����ִ����Լ����ְ���.
--���ߣ�@MaSaXX

--������־---------------------------------------------------------------------------
--ʱ�䣺2016.07.24
--Ver 0.6.0 Beta
--1.���ģ���дԶ�����պ��Ĵ��룬�������Ч��
--2.�������������������⿨ס�����Զ�������Ϸ
--3.��������������³��ֳ������0x010��������Զ�������Ϸ���ָ�Զ��
--4.������������������Զ���ͼ��������KCA��screenshotĿ¼�£��Դ������������
--5.������������������

require("API��չ")

local ͨ�� = require("ͨ��")
local ȡɫ = require("Զ��_ȡɫ")
local ���� = ͨ��.����
local ���� = ͨ��.����

local Զ�� = {}

function Զ��.Time_ID(TimeID)
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

function Զ��.Point_ID(PointID)
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

--������ѡ��ʱ��������ô˺���(������
function Զ��.GoToAge()
    ����.ȥ�������()
    -- ȥԶ������
    repeat
        Base.ClickRect(281, 406, 30)
        Base.Sleep(500, true)
    until �ȴ�(ȡɫ.ExpChoice_IsColorAll)
    Win.Print("Զ��������Զ������")
end

function Զ��.TeamGo(Team, Map, Point)

    -- ѡ��ʱ����Ŀ�ĵ�
    ȡɫ.Time_ID(Map)
    Base.Sleep(500, true)
    ȡɫ.Point_ID(Point)
    Base.Sleep(500, true)

    if not ȡɫ.TeamChoiceGreen_IsColorAll() then
        Win.Print("Զ������⵽" .. Map .. "-" .. Point .. "�оɵ�Զ��δ��ɣ�����")
        Base.Sleep(500, true)
        return 0
    end

    Base.ClickRectEx(679, 523, 70, 15)  --ѡ�����
    Base.Sleep(1000)  --�ȴ�1��

    local fail_count = 0
    while not ȡɫ.TeamChoice_IsColorAll() do
        Win.Print("Զ����û�е������ѡ����棬�ȴ�2������")
        Base.Sleep(2000)
        fail_count = fail_count + 1
        if fail_count > 2 then
            Win.Print("Զ����ʧ�ܳ���2�Σ���ξͲ�Զ����")
            Base.Sleep(500, true)
            Base.ClickRect(636, 338)
            return 0
        end
    end
    --�ɹ��������ѡ�����

    Base.Sleep(500)   --�ȴ�0.5��
    if Team == 4 then
        Base.ClickRectEx(231, 66, 10, 6)  --������鰴ť
        Base.Sleep(2000)   --�ȴ�2��
        Base.ClickRectEx(224, 111, 8, 6)  --ѡ�����4
        Base.Sleep(2000)   --�ȴ�2��
    elseif Team == 3 then
        Base.ClickRectEx(231, 66, 10, 6)  --������鰴ť
        Base.Sleep(2000)   --�ȴ�2��
        Base.ClickRectEx(231, 93, 8, 6)  --ѡ�����3
        Base.Sleep(2000)   --�ȴ�2��
    end
    --�ɹ�ѡ�����

    if ȡɫ.TeamChoiceERROR_IsColorAll() then
        Win.Print("Զ����Ŀǰѡ���������Զ���У��޷�ѡ��")
        Base.Sleep(500, true)
        Base.ClickRect(561, 499)
        return 0
    end

    Base.ClickRect(694,500)  --Զ����ʼ
    Base.Sleep(7000)   --�ȴ�7��

    Win.Print("Զ�����ɹ���ʼ��" .. tostring(Team) .. "��Զ��")
    return 1
end

function Զ��.ִ��(self)
    local ���������� = 0
    Win.Print("Զ������ʼִ�У��趨 = " .. require("inspect")(self.�趨))

    ����.�ȴ�����()
    Զ��.GoToAge()

    repeat
        Base.ClickRect(142, 187) -- ȷ���ڵ�һҳ
        Base.Sleep(500, true)
        Base.Click(204, 188) -- ���ʱ��1
        Base.Sleep(500, true)
    until �ȴ�(ȡɫ.AgeOne_IsColorAll)

    --�ɹ�����1-4��ʱ������
    for i = 1, 3, 1 do
        if self.�趨.Զ������ʱ��[i] ~= nil then
            ���������� = ���������� + Զ��.TeamGo(i + 1, self.�趨.Զ������ʱ��[i][1], self.�趨.Զ������ʱ��[i][2])
        end
    end

    ����.�ر���()
    Win.Print("Զ����������������ɳ�".. tostring(����������) .. "�ӵ���ȥԶ��")
    return ����������
end

function Զ��:new(�趨)
    local instance = {}
    setmetatable(instance, {__index = Զ��})
    instance.�趨 = �趨
    return instance
end

setmetatable(Զ��, {__call = Զ��.new})

return Զ��
