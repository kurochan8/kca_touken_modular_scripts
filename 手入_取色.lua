--[[
��_ģ�黯�ű� v0.1 by Ⱥ��@�\�勞��
����_ȡɫ�� ���ֻ�������ű�v1.2��ȡɫpart�� by ��̳@sakura_candy��Ⱥ��@��������
--]]

require("API��չ")

local ȡɫ = {}
ȡɫ.ѡ������ = {
    ��λ�� = {
        {128, 80},
        {128, 157},
        {128, 234},
        {128, 311},
        {128, 388},
        {128, 465},
    },
    Ѫ����� = 137,
}

function ȡɫ.�����������()
    return Base.IsColorAll({
        {165, 106, 14220285},
        {732, 256, 10740205},
    })
end

function ȡɫ.������벿��״̬()
    -- 1�ŷ���
    return Base.IsColorAll({
        {440, 138, 9015441},
        {361, 104, 4016202},
        {541, 174, 1120797},
    -- 2�ŷ���
    }), Base.IsColorAll({
        {362, 221, 4147788},
        {451, 256, 16777215},
        {527, 283, 1450532},
    -- 3�ŷ���
    }), Base.IsColorAll({
        {358, 350, 3753287},
        {514, 396, 285},
    -- 4�ŷ���
    }), Base.IsColorAll({
        {452, 462, 206664},
        {374, 503, 2174512},
    })
end

function ȡɫ.�����뷿����()
    return Base.IsColorAll({
        {552, 279, 7830397},
        {745, 443, 13233909},
    })
end

function ȡɫ.��鵶Ѫ��()
    local check_sword_hp = function (coord)
        local x, y = table.unpack(coord)
        local actual_hp = ȡɫ.ѡ������.Ѫ�����
        while Base.IsColor(x + 8 + actual_hp - 1, y + 66, 407914) do
            actual_hp = actual_hp - 1
        end
        return actual_hp / ȡɫ.ѡ������.Ѫ�����
    end
    return table.unpack(table.map(ȡɫ.ѡ������.��λ��, check_sword_hp))
end

function ȡɫ.��鵶�Ƿ���������()
    local check_sword_status = function (coord)
        local x, y = table.unpack(coord)
        return Base.IsColorAll({
            -- ����ȡ�ĵ��ر�������׼ȷ�Ȳ���ӣ��ѩ��Ӱ��
            {x + 184, y + 50, 15232533},
            {x + 198, y + 50, 15232533},
        })
    end
    return table.unpack(table.map(ȡɫ.ѡ������.��λ��, check_sword_status))
end

function ȡɫ.��ѡ��()
    return Base.IsColorAll({
        {516, 281, 2175839},
        {707, 282, 2175581},
    })
end

function ȡɫ.��ѡ��������()
    return Base.IsColorAll({
        {712, 477, 8542689},
        {565, 502, 4260561},
    })
end

return ȡɫ
