--[[
��_ģ�黯�ű� v0.1 by Ⱥ��@�\�勞��
ͨ�ã�����һЩ�ܶ�����ﶼͨ�õĶ������õ�ʱ����ʱ�����
--]]

require("API��չ")

local ͨ�� = {}

-- ��ʽ����
local ���� = {
    ���˰ٷֱ� = {
        ΢�� = 0.999,
        ���� = 0.9,
        ���� = 0.65,
        ���� = 0.31,
    },
    ���벿�� = {
        ��λ�� = {
            {128, 80},
            {128, 157},
            {128, 234},
            {128, 311},
            {128, 388},
            {128, 465},
        },
        Ѫ����� = 137,
    },
    ��ҳλ�� = {
        ��� = {320, 543},
        ���� = {316, 543},
    },
}
ͨ��.���� = ����


-- �������
local ���� = {}

function ����.�ڱ���()
    return Base.IsColor(53, 72, 11397105)
end

function ����.�ر���()
    repeat
        Base.ClickRectEx(900, 65, 50, 10)
        Base.Sleep(500, true)
    until �ȴ�(����.�ڱ���)
    Win.Print("ͨ�ã����ر���")
end

function ����.�ȴ�����()
    Win.Print("ͨ�ã��ȴ�����")
    while true do
        if �ȴ�(����.�ڱ���) then
            break
        end
    end
end

ͨ��.���� = ����


-- ��ҳ���
local ��ҳ = {}

function ��ҳ.��ǰ������Է�ҳ(self)
    return Base.IsOneOfColorsAll({
        {0 + self.x_offset, 7 + self.y_offset},
        {268 + self.x_offset, 7 + self.y_offset},
    }, {
        3355443,
        5046092,
    })
end

function ��ҳ.����ҳ(self)
    return Base.IsColor(0 + self.x_offset, 7 + self.y_offset, 3355443)
end

function ��ҳ.��βҳ(self)
    return Base.IsColor(268 + self.x_offset, 7 + self.y_offset, 3355443)
end

function ��ҳ.ȥ��һҳ(self)
    Base.ClickRect(32 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function ��ҳ.ȥ��һҳ(self)
    Base.ClickRect(235 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function ��ҳ.ȥ��ҳ(self)
    Base.ClickRect(6 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function ��ҳ.ȥβҳ(self)
    Base.ClickRect(262 + self.x_offset, 7 + self.y_offset, 10)
    Base.Sleep(500)
end

function ��ҳ:new(x_offset, y_offset)
    local instance = {}
    setmetatable(instance, {__index = ��ҳ})
    instance.x_offset = x_offset
    instance.y_offset = y_offset
    return instance
end

setmetatable(��ҳ, {__call = ��ҳ.new})

ͨ��.��ҳ = ��ҳ

return ͨ��
