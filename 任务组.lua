--[[
��_ģ�黯�ű�
�����飺���ڿ��ƶ������Ĵ�����ѭ������
���ߣ��\�勞��
--]]

require("API��չ")

local ������ = {}

function ������.��ʼ����(self)
    local ����ʼʱ�� = os.time()
    Win.Print("�����飺��ʼ����")
    local return_code = 0
    for i = 1, self.ѭ������, 1 do
        local ��ǰʱ�� = os.time()
        if self.��ʱ > 0 and ��ǰʱ�� - ����ʼʱ�� > self.��ʱ then
            Win.Print("�����飺ִ�г�ʱ����������")
            return -1
        end

        Win.Print("�����飺��ʼִ�е�" .. tostring(i) .. "��ѭ��")

        for j = 1, #self.��������, 1 do
            if type(self.��������[j]) == "function" then
                return_code = self.��������[j]()
            elseif self.��������[j]["ִ��"] and type(self.��������[j]["ִ��"]) == "function" then
                return_code = self.��������[j]["ִ��"](self.��������[j])
            else
                Win.Print("�����飺��⵽��Ч������ֹ����")
                Win.Print("�����飺" .. require("inspect")(self.��������[j]))
                return -1
            end
            --����κ�һ����������˾�ֱ�ӷ���
            if return_code < 0 then
                Win.Print("�����飺���������ֹ���У��������"..return_code)
                return return_code
            end

        end
    end
    Win.Print("�����飺����ָ��ѭ����������������")
    return return_code
end

function ������:new(��������, ѭ������, ��ʱ)
    local instance = {}
    setmetatable(instance, {__index = ������})
    Base.SetConfig("Sleep+?", ȫ���趨.������ʱ����)
    instance.�������� = ��������
    instance.ѭ������ = ѭ������ or 2147483647
    instance.��ʱ = ��ʱ or 86400
    return instance
end

setmetatable(������, {__call = ������.new})

return ������
