--[[
��_ģ�黯�ű� v0.1 by Ⱥ��@�\�勞��
���룺���ֻ�������ű�v1.3����л��̳@sakura_candy��Ⱥ��@��������
--]]

require("API��չ")

local ͨ�� = require("ͨ��")
local ���� = ͨ��.����
local ���� = ͨ��.����
local ��ҳ = ͨ��.��ҳ(����.��ҳ.ȫ��λ��.����, ����.��ҳ.����λ��.����)
local ȡɫ = require("����_ȡɫ")

local ���� = {}

function ����.����������(self)
    repeat
        Base.ClickRectEx(907, 270, 80, 30)
        Base.Sleep(500, true)
    until �ȴ�(ȡɫ.����������)
    Win.Print("���룺�������뻭��")
end

function ����.�������벿��(self, n)
    repeat
        Base.ClickRectEx(451, 136 + (n - 1) * 121, 600, 80)
        Base.Sleep(500, true)
    until �ȴ�(ȡɫ.�����벿����)
    Win.Print("���룺����" .. tostring(n) .. "�����벿��")
end

function ����.ѡ��(self, n)
    repeat
        Base.ClickRectEx(454, 118 + (n - 1) * 77, 20, 20)
        Base.Sleep(500, true)
    until �ȴ�(ȡɫ.��ѡ��)
    Win.Print("���룺ѡ�е�ǰҳ���" .. tostring(n) .. "�ѵ�")
end

function ����.ʹ�ü���(self)
    Base.ClickRectEx(670, 392, 100, 8)
    Base.Sleep(500)
    Base.ClickRectEx(670, 413, 100, 8)
    Base.Sleep(500)
    Win.Print("���룺ʹ�ü���")
end

function ����.��ʼ����(self)
    repeat
        Base.ClickRectEx(635, 490, 150, 30)
        Base.Sleep(500)
    until �ȴ�(ȡɫ.����������)
    Win.Print("���룺��ʼ����")
end

function ����.ִ��(self)
    local �����Ƶ��� = 0
    Win.Print("���룺��ʼִ�У��趨 = " .. require("inspect")(self.�趨))

    ����.�ȴ�����()

    self:����������()

    while true do
        �ȴ�(ȡɫ.����������)

        -- ��˼��״_(:3����)_
        Base.Sleep(1000, true)

        local ���벿��״̬ = {ȡɫ.������벿��״̬()}
        for i, v in ipairs(self.�趨.���ò���) do
            ���벿��״̬[i] = ���벿��״̬[i] and v
        end

        local ʹ��������벿�� = table.index_of(���벿��״̬, true)
        if ʹ��������벿�� == 0 then
            break
        end

        self:�������벿��(ʹ��������벿��)
        Win.Print("���룺��ʼ��鵶��״̬")

        local ��ǰҳ�� = 1
        local ��Ҫ����ĵ��� = {}

        while true do

            -- ��˼��״_(:3����)_
            Base.Sleep(1000, true)

            local ɨ����� = false
            local ��ǰҳ�浶��Ѫ�� = {ȡɫ.��鵶Ѫ��()}
            local ��ǰҳ�浶������״̬ = {ȡɫ.��鵶�Ƿ���������()}

            for ��ǰλ��, ��ǰѪ�� in ipairs(��ǰҳ�浶��Ѫ��) do

                if ��ǰѪ�� == 1 then
                    ɨ����� = true
                    break
                end

                if not ��ǰҳ�浶������״̬[��ǰλ��] and ��ǰѪ�� <= ����.���˰ٷֱ�[self.�趨.�������˵ȼ�] then
                    table.insert(��Ҫ����ĵ���, {
                        ҳ�� = ��ǰҳ��,
                        λ�� = ��ǰλ��,
                        Ѫ�� = ��ǰѪ��,
                    })
                end
            end

            if ɨ����� or not self.�趨.�������Ƹ����˵ȼ� and #��Ҫ����ĵ��� > 0 or ��ҳ:��βҳ() then
                break
            end

            ��ҳ:ȥ��һҳ()
            ��ǰҳ�� = ��ǰҳ�� + 1
        end

        if #��Ҫ����ĵ��� == 0 then
            break
        end

        if self.�趨.�������Ƹ����˵ȼ� then
            table.sort(��Ҫ����ĵ���, function (a, b) return a.Ѫ�� < b.Ѫ�� end)
        end

        local Ҫִ������ĵ� = ��Ҫ����ĵ���[1]
        Win.Print("���룺���ҵ���Ҫ���Ƶĵ���")

        if Ҫִ������ĵ�.ҳ�� > 1 then
            ��ҳ:ȥ��ҳ()
            for i = 1, Ҫִ������ĵ�.ҳ�� - 1, 1 do
                ��ҳ:ȥ��һҳ()
            end
        end

        self:ѡ��(Ҫִ������ĵ�.λ��)
        �ȴ�(ȡɫ.��ѡ��)

        if not ȡɫ.��ѡ��������() then
            Win.Print("���룺�ű������쳣")
            return 0
        end

        if self.�趨.ʹ�ü������˵ȼ� and Ҫִ������ĵ�.Ѫ�� <= ����.���˰ٷֱ�[self.�趨.ʹ�ü������˵ȼ�] then
            self:ʹ�ü���()
        end

        �����Ƶ��� = �����Ƶ��� + 1
        self:��ʼ����()
    end

    ����.�ر���()
    Win.Print("���룺���������������" .. tostring(�����Ƶ���) .. "�ѵ�")
    return �����Ƶ���
end

function ����:new(�趨)
    local instance = {}
    setmetatable(instance, {__index = ����})
    instance.�趨 = �趨
    return instance
end

setmetatable(����, {__call = ����.new})

return ����
