--[[
��_ģ�黯�ű� v0.1 by Ⱥ��@�\�勞��
ͨ�ã� ����һЩ�ܶ�����ﶼͨ�õĶ������õ�ʱ����ʱ�����
--]]

require("API��չ")

local ͨ�� = {}

-- ��ҳ���
-- ��ɣ� 320, 543
-- ���룺 316, 543

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

function ��ҳ.������ҳ(self)
    return Base.IsColor(0 + self.x_offset, 7 + self.y_offset, 3355443)
end

function ��ҳ.����βҳ(self)
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
