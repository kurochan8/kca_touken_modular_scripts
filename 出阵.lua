--[[
��_ģ�黯�ű�
���󣺸�д�Դ�Ҷ�����Ϥ�����ĸ�ͼ�ű�
ģ�黯���ߣ��\�勞��
--]]

require("API��չ")

local ͨ�� = require("ͨ��")
local ���� = ͨ��.����
local ���� = ͨ��.����
local ��� = ͨ��.���
local ���� = ͨ��.����

local ���� = {}

function ����.GetMode(self)
    local mode = 0
    if self.�趨.ս�����������ֹͣ�ű� then
        mode = mode + 4
    end
    if self.�趨.ս��������ֹͣ�ű� then
        mode = mode + 1
    end
    if self.�趨.ս��������ֹͣ�ű� then
        mode = mode + 2
    end
    return mode
end

function ����.ִ��(self)
    local mode = self:GetMode()
    Win.Print("���󣺿�ʼִ�У��趨 = " .. require("inspect")(self.�趨))

    ����.�ȴ�����()

    -- Ϊ�˾��������鵶�Ҿ���һ�¶������Ƿ�������Ա
    if self.�趨.���˺�ֹͣ�ű� then
        ���.ȥ��ɽ���()
        ���.ѡ�����(self.�趨.Ҫ�����Ķ���)
        local ��Ѫ�� = {���.��鵶Ѫ��()}

        -- ��˼��״_(:3����)_
        Base.Sleep(1000, true)
        for i, v in ipairs(��Ѫ��) do
            if v > 0 and v <= ����.���˰ٷֱ�.���� then
                Win.Print("���󣺶�����������Ա���жϽű�")
                return -1
            end
        end

        Win.Print("���󣺶�����û������Ա����ʼ����")
        ����.�ر���()
    end

    if not Touken.����(self.�趨.��ͼ[1], self.�趨.��ͼ[2], self.�趨.������ǲ������ͼ) then
        Win.Print("�����޷������˳�")
        return -1
    end

    local ret = Tou.Battle(self.�趨.��������ٴ�ս����, self.�趨.����ʧ�ܺ�ʹ�õ�����, mode, self.�趨.Ҫ�����Ķ���, self.�趨.�Ƿ����ӵȼ���ʾ)

    if ret > 0 and not self.�趨.���˺�ֹͣ�ű� then
        Win.Print("�����ж�Ա���ˣ��жϽű�")
        return -1
    end

    if ret == -1 then
        Win.Print("���󣺷��ּ�ǣ����½�����Ϸ")
        Base.ReLoad()
        repeat
            Base.Click(468, 453)
        until �ȴ�(Base.IsColor, 468, 453, 7747046)
    end

    if ret == -2 then
        Win.Print("���󣺳����ȼ����жϽű�")
        return -1
    end

    return ret
end

function ����:new(�趨)
    local instance = {}
    setmetatable(instance, {__index = ����})
    instance.�趨 = �趨
    return instance
end

setmetatable(����, {__call = ����.new})

return ����
