--[[
ģ�黯��ֲ��sakura_candy���������㣩
Զ��_ȡɫ��MaSaXX
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

local Զ�� = {}

local Num = 0

------------------------------------------------------------------------------------

function Զ��.Init()      --��ʼ������

    while ȡɫ.SwordList_IsColorAll() == true do
        Base.ClickRect(859,548,4)  --�ر���
        Base.Sleep(500)
     end

    while ȡɫ.Mail_IsColorAll() == true do
        Base.ClickRect(770,69,10)  --�ر���
        Base.Sleep(500)
     end

    Base.ClickRectEx(900,65,50,10)  --��ʼ���ر���
    Base.Sleep(1000)  --�ȴ�1��


    ͨ��.����.�ر���()
    --�ɹ����뱾�����

    Win.Print("��ʼ�������������У����Ժ�...")
   -- Win.SetState("��ʼ����ɣ��ȴ�������׶�...")
end

function Զ��.GoToAge()      --������ѡ��ʱ��������ô˺���(������

    Base.ClickRectEx(908,111,20,8)  --����
    Base.Sleep(1500)  --�ȴ�1��
     while ȡɫ.Attack_IsColorAll() == false do
        Win.Print("�������:0x010 δ�ܽ��������棬�ȴ�2�����ԣ���һֱ��ʾ����Ϸ+KCA��ͼ")
        Base.Sleep(2000)
        Base.ClickRectEx(908,111,20,8)  --���µ������
    end
    --�ɹ�����������

    Base.ClickRect(281,406,30)  --Զ��
    Base.Sleep(2000)  --�ȴ�2��

    while ȡɫ.ExpChoice_IsColorAll() == false do
        Win.Print("�������:0x004 û�е���Զ������棬�ȴ�2������")
        Base.Sleep(2000)
    end
    --�ɹ�����Զ������
end

function Զ��.TeamGo(Team, Map, Point)
    while ȡɫ.AgeOne_IsColorAll() == false do
        Win.Print("�������:0x005B û�лص�1-4��ʱ�����棬�ȴ�3������")
        Base.Sleep(8000)
        ȡɫ.Time_ID(Point)
    end

    ȡɫ.Time_ID(Map)
    Base.Sleep(800)
    ȡɫ.Point_ID(Point)
    Base.Sleep(800)

    if ȡɫ.TeamChoiceGreen_IsColorAll() == false then
        Win.Print("��ʼ������⵽" .. Map .. "-" .. Point .. "�оɵ�Զ��δ��ɣ�����")
        Base.Sleep(1000)
        return
    end

    Base.ClickRectEx(679,523,70,15)  --ѡ�����
    Base.Sleep(1000)  --�ȴ�1��

    fail_count = 0
    while ȡɫ.TeamChoice_IsColorAll() == false do
        Win.Print("û�е������ѡ����棬�ȴ�2������")
        Base.Sleep(2000)
        fail_count = fail_count+1
        if fail_count > 2 then
            Win.Print("ʧ�ܳ���2�Σ���ξͲ�Զ����")
            Base.ClickRect(636,338)
            return
        end
    end
    --�ɹ��������ѡ�����

    Base.Sleep(500)   --�ȴ�0.5��
    if Team == 4 then
        Base.ClickRectEx(231,66,10,6)  --������鰴ť
        Base.Sleep(2000)   --�ȴ�2��
        Base.ClickRectEx(224,111,8,6)  --ѡ�����4
        Base.Sleep(2000)   --�ȴ�2��
    elseif Team == 3 then
        Base.ClickRectEx(231,66,10,6)  --������鰴ť
        Base.Sleep(2000)   --�ȴ�2��
        Base.ClickRectEx(231,93,8,6)  --ѡ�����3
        Base.Sleep(2000)   --�ȴ�2��
    end

    while ȡɫ.TeamChoiceERROR_IsColorAll() == true do
        Win.Print("Ŀǰѡ���������Զ���У��޷�ѡ��")
        Base.Sleep(800)
        Base.ClickRect(561,499)
        return
    end
    --�ɹ�ѡ�����

    Base.ClickRect(694,500)  --Զ����ʼ
    Base.Sleep(7000)   --�ȴ�7��
    Win.Print("��ʾ���ɹ���ʼ��"..Team.."��Զ��")
    Num = Num + 1

end

function Զ��.ִ��(self)
    Win.Print("Զ������ʼִ�У��趨 = " .. require("inspect")(self.�趨))

    Զ��.Init()
    Win.Print("��ʼ������ɣ�������һ�׶�...")
    Զ��.GoToAge()
    Base.ClickRect(142,187)  --ȷ���ڵ�һҳ
        while ȡɫ.AgeOne_IsColorAll() == false do
            Win.Print("�������:0x005 û�е�1-4��ʱ�����棬�ȴ�2������")
            Base.Sleep(2000)
        end
        Base.Sleep(200)
        Base.Click(204,188) --���ʱ��1
        Base.Sleep(200)
        --�ɹ�����1-4��ʱ������
        if self.�趨.Զ������ʱ��[1] ~= nil then
            Զ��.TeamGo(2, self.�趨.Զ������ʱ��[1][1], self.�趨.Զ������ʱ��[1][2])
        end
        if self.�趨.Զ������ʱ��[2] ~= nil then
            Զ��.TeamGo(3, self.�趨.Զ������ʱ��[2][1], self.�趨.Զ������ʱ��[2][2])
        end
        if self.�趨.Զ������ʱ��[3] ~= nil then
            Զ��.TeamGo(4, self.�趨.Զ������ʱ��[3][1], self.�趨.Զ������ʱ��[3][2])
        end

        ͨ��.����.�ر���()
        Win.Print("Զ�����������")
        return Num
end

function Զ��:new(�趨)
    local instance = {}
    setmetatable(instance, {__index = Զ��})
    instance.�趨 = �趨
    return instance
end

setmetatable(Զ��, {__call = Զ��.new})

return Զ��