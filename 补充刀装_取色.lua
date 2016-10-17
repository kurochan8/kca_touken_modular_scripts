--[[
刀_模块化脚本 v0.1 by 群内@黒田くん
补充刀装_取色：补充刀装模块取色部分，就是一堆
--]]

require("API扩展")

local 取色 = {}
local 常量 = require("通用").常量

local 取色信息 = {
    -- 133
    -- 83 161 239 317 395 473
    种类 = {
        投石兵 = {
            {12, 26, 10731719},
            {17, 20, 7036242},
        },
        槍兵 = {
            {11, 25, 3229023},
            {17, 21, 4740972},
        },
        軽歩兵 = {
            {7, 24, 5592918},
            {23, 20, 15920879},
        },
        重歩兵 = {
            {9, 14, 4163764},
            {14, 9, 14671843},
        },
        盾兵 = {
            {20, 20, 2031736},
            {18, 27, 3502495},
        },
        軽騎兵 = {
            {16, 3, 12951163},
            {18, 22, 2436478},
        },
        重騎兵 = {
            {14, 5, 4076960},
            {17, 24, 11305828},
        },
        精鋭兵 = {
            {10, 8, 4889742},
            {15, 15, 9041917},
        },
        弓兵 = {
            {17, 21, 3360865},
            {13, 25, 1716304},
        },
        銃兵 = {
            {11, 22, 1654115},
            {18, 20, 1520724},
        },
    },
    质量 = {
        特上 = {
            {2, 3, 13429229},
            {27, 27, 1085595},
        },
        上 = {
            {2, 3, 15329769},
            {27, 27, 9145227},
        },
        並 = {
            {2, 3, 14869973},
            {27, 27, 7175732},
        },
    },
}

function 取色.检查刀装状态()
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

function 取色.在装备变更界面()
    return Base.IsColorAll({
        {371, 66, 14346992},
        {406, 151, 7502974},
        {761, 390, 7502718},
    })
end

function 取色.装备选择界面已打开()
    return Base.IsColorAll({
        {119, 62, 1600656},
        {119, 556, 1731471},
    })
end

function 取色.取得装备信息(n)
    if not n then return 快速测试2(取色.取得装备信息, 6) end
    local translate_coord = function (a)
        return {a[1] + 133, a[2] + 5 + n * 78, a[3]}
    end
    local result = 0
    for key, value in pairs(取色信息.质量) do
        if Base.IsColorAll(table.map(value, translate_coord)) then
            result = result + 常量.刀装.质量[key]
            break
        end
    end
    for key, value in pairs(取色信息.种类) do
        if Base.IsColorAll(table.map(value, translate_coord)) then
            result = result + 常量.刀装.种类[key]
            break
        end
    end
    return result
end

function 取色.已选择刀装(n)
    if not n then return 快速测试2(取色.已选择刀装, 6) end
    return Base.IsColorAll({
        {302, 13 + n * 78, 7039990},
        {333, 26 + n * 78, 131820},
    })
end

function 取色.已装备刀装(n)
    if not n then return 快速测试2(取色.已装备刀装, 3) end
    return Base.IsColorAll({
        {535, 141 + n * 38, 526508},
        {551, 156 + n * 38, 65905},
    })
end

function 取色.取得当前页面装备信息()
    local result = {}
    for i = 1, 6, 1 do
        table.insert(result, 取色.取得装备信息(i))
    end
    return result
end

return 取色
