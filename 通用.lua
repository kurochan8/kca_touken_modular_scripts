--[[
��_ģ�黯�ű�
ͨ�ã�����һЩ�ܶ�����ﶼͨ�õĶ������õ�ʱ����ʱ�����
���ߣ��\�勞��
--]]

require("API��չ")

local ͨ�� = {}

-- ��ʽ����
local ���� = {
    ��װ = {
        ���� = {
            Ͷʯ�� = 1,
            ���� = 2,
            �X�i�� = 3,
            �ؚi�� = 4,
            �ܱ� = 5,
            �X�T�� = 6,
            ���T�� = 7,
            ��䄱� = 8,
            ���� = 9,
            �|�� = 10,
        },
        ���� = {
            ���� = 100,
            �� = 200,
            �K = 300,
        },
    },
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
    ��ҳ = {
        ȫ��λ�� = {
            ��� = {320, 543},
            ���� = {316, 543},
            װ��ѡ�� = {127, 548},
        },
        ����λ�� = {
            ��� = {6, 32, 235, 262},
            ���� = {6, 32, 235, 262},
            װ��ѡ�� = {6, 22, 194, 211},
        },
    },
}
ͨ��.���� = ����


-- �������
local ���� = {}

function ����.�ڱ���()
    return Base.IsColor(53, 72, 11397105)
end

function ����.������()
    return Base.IsColor(730, 157, 6931435)
end

function ����.�ڵ���()
    return Base.IsColor(853, 556, 353499)
end

function ����.�ر���()
    repeat
        if ����.������() then
            Base.ClickRect(770, 69, 10)
        elseif ����.�ڵ���() then
            Base.ClickRect(859, 548, 4)
        else
            Base.ClickRectEx(900, 65, 50, 10)
        end
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

-- �������
local ���� = {}

function ����.�ڳ������()
    return Base.IsColor(218, 179, 10178876)
end

function ����.ȥ�������()
    repeat
        Base.ClickRectEx(908, 111, 20, 8)
        Base.Sleep(500, true)
    until �ȴ�(����.�ڳ������)
    Win.Print("ͨ�ã�����������")
end

ͨ��.���� = ����

-- ������
local ��� = {}

function ���.�ڽ�ɽ���()
    return Base.IsColorAll({
        {877, 143, 3750327},
        {943, 159, 526464},
    })
end

function ���.ȥ��ɽ���()
    repeat
        Base.ClickRectEx2(864, 135, 949, 165)
        Base.Sleep(500, true)
    until �ȴ�(���.�ڽ�ɽ���)
    Win.Print("ͨ�ã������ɽ���")
end

-- ����ṩn����������boolean��������ṩn��������������
function ���.��ǰ������(n)
    local result = 0
    if Base.IsColorAll({
        {779, 85, 13760508},
        {766, 155, 6996971},
    }) then result = 1 end
    if Base.IsColorAll({
        {779, 218, 13760508},
        {766, 291, 6996971},
    }) then result = 2 end
    if Base.IsColorAll({
        {779, 349, 13760508},
        {765, 424, 6996971},
    }) then result = 3 end
    if Base.IsColorAll({
        {779, 482, 13760508},
        {765, 555, 6996971},
    }) then result = 4 end
    if n then
        return result == n
    else
        return result
    end
end

function ���.ѡ�����(n)
    if ���.��ǰ������(n) then
        return
    end
    repeat
        Base.ClickRectEx2(761, -67 + 132 * n, 781, 34 + 132 * n)
        Base.Sleep(500, true)
    until �ȴ�(���.��ǰ������, n)
    Win.Print("ͨ�ã��л�������" .. tostring(n))
end

ͨ��.��� = ���


-- ��ҳ���
local ��ҳ = {}

function ��ҳ.��ǰ������Է�ҳ(self)
    return Base.IsOneOfColorsAll({
        {self.overall_offsets[1], 4 + self.overall_offsets[2]},
        {self.overall_offsets[1], 10 + self.overall_offsets[2]},
    }, {
        3355443,
        5046092,
    })
end

function ��ҳ.����ҳ(self)
    return Base.IsColor(self.control_offsets[1] + self.overall_offsets[1] - 6, 7 + self.overall_offsets[2], 3355443)
end

function ��ҳ.��βҳ(self)
    return Base.IsOneOfColors({
        self.control_offsets[4] + self.overall_offsets[1] + 6,
        7 + self.overall_offsets[2],
    }, {
        3355443,
        2763306,
    })
end

function ��ҳ.ȥ��һҳ(self)
    Base.ClickRect(self.control_offsets[2] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function ��ҳ.ȥ��һҳ(self)
    Base.ClickRect(self.control_offsets[3] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function ��ҳ.ȥ��ҳ(self)
    Base.ClickRect(self.control_offsets[1] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function ��ҳ.ȥβҳ(self)
    Base.ClickRect(self.control_offsets[4] + self.overall_offsets[1], 7 + self.overall_offsets[2], 10)
    Base.Sleep(500)
end

function ��ҳ:new(overall_offsets, control_offsets)
    local instance = {}
    setmetatable(instance, {__index = ��ҳ})
    instance.overall_offsets = overall_offsets
    instance.control_offsets = control_offsets
    return instance
end

setmetatable(��ҳ, {__call = ��ҳ.new})

ͨ��.��ҳ = ��ҳ


return ͨ��
