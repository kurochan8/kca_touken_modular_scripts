--[[
��_ģ�黯�ű� v0.1 by Ⱥ��@�\�勞��
���䵶װ_ȡɫ�����䵶װģ��ȡɫ���֣�����һ��
--]]

require("API��չ")

local ȡɫ = {}
local ���� = require("ͨ��").����

local ȡɫ��Ϣ = {
    -- 133
    -- 83 161 239 317 395 473
    ���� = {
        Ͷʯ�� = {
            {12, 26, 10731719},
            {17, 20, 7036242},
        },
        ���� = {
            {11, 25, 3229023},
            {17, 21, 4740972},
        },
        �X�i�� = {
            {7, 24, 5592918},
            {23, 20, 15920879},
        },
        �ؚi�� = {
            {9, 14, 4163764},
            {14, 9, 14671843},
        },
        �ܱ� = {
            {20, 20, 2031736},
            {18, 27, 3502495},
        },
        �X�T�� = {
            {16, 3, 12951163},
            {18, 22, 2436478},
        },
        ���T�� = {
            {14, 5, 4076960},
            {17, 24, 11305828},
        },
        ��䄱� = {
            {10, 8, 4889742},
            {15, 15, 9041917},
        },
        ���� = {
            {17, 21, 3360865},
            {13, 25, 1716304},
        },
        �|�� = {
            {11, 22, 1654115},
            {18, 20, 1520724},
        },
    },
    ���� = {
        ���� = {
            {2, 3, 13429229},
            {27, 27, 1085595},
        },
        �� = {
            {2, 3, 15329769},
            {27, 27, 9145227},
        },
        �K = {
            {2, 3, 14869973},
            {27, 27, 7175732},
        },
    },
}

function ȡɫ.��鵶װ״̬()
    local result = {}
    for i = 1, 6, 1 do
        table.insert(result, {
            Base.IsColor(507, 60 + i * 77, 16777215),
            Base.IsColor(542, 60 + i * 77, 16777215),
            Base.IsColor(577, 60 + i * 77, 16777215),
        })
    end
    return result
end

function ȡɫ.��װ���������()
    return Base.IsColorAll({
        {371, 66, 14346992},
        {406, 151, 7502974},
        {761, 390, 7502718},
    })
end

function ȡɫ.װ��ѡ������Ѵ�()
    return Base.IsColorAll({
        {119, 62, 1600656},
        {119, 556, 1731471},
    })
end

function ȡɫ.ȡ��װ����Ϣ(n)
    if not n then return ���ٲ���2(ȡɫ.ȡ��װ����Ϣ, 6) end
    local translate_coord = function (a)
        return {a[1] + 133, a[2] + 5 + n * 78, a[3]}
    end
    local result = 0
    for key, value in pairs(ȡɫ��Ϣ.����) do
        if Base.IsColorAll(table.map(value, translate_coord)) then
            result = result + ����.��װ.����[key]
            break
        end
    end
    for key, value in pairs(ȡɫ��Ϣ.����) do
        if Base.IsColorAll(table.map(value, translate_coord)) then
            result = result + ����.��װ.����[key]
            break
        end
    end
    return result
end

function ȡɫ.��ѡ��װ(n)
    if not n then return ���ٲ���2(ȡɫ.��ѡ��װ, 6) end
    return Base.IsColorAll({
        {302, 13 + n * 78, 7039990},
        {333, 26 + n * 78, 131820},
    })
end

function ȡɫ.��װ����װ(n)
    if not n then return ���ٲ���2(ȡɫ.��װ����װ, 3) end
    return Base.IsColorAll({
        {535, 141 + n * 38, 526508},
        {551, 156 + n * 38, 65905},
    })
end

function ȡɫ.ȡ�õ�ǰҳ��װ����Ϣ()
    local result = {}
    for i = 1, 6, 1 do
        table.insert(result, ȡɫ.ȡ��װ����Ϣ(i))
    end
    return result
end

return ȡɫ
