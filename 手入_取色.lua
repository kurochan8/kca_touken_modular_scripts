--[[
刀_模块化脚本 v0.1 by 群内@黒田くん
手入_取色：很大一部分基于手入脚本v1.2（取色part），感谢论坛@sakura_candy，群内@肝力不足
--]]

require("API扩展")

local 取色 = {}
local 常量 = require("通用").常量

function 取色.在主界面内()
    return Base.IsColorAll({
        {165, 106, 14220285},
        {732, 256, 10740205},
    })
end

function 取色.检查手入部屋状态()
    -- 1号房间
    return Base.IsColorAll({
        {440, 138, 9015441},
        {361, 104, 4016202},
        {541, 174, 1120797},
    -- 2号房间
    }), Base.IsColorAll({
        {362, 221, 4147788},
        {451, 256, 16777215},
        {527, 283, 1450532},
    -- 3号房间
    }), Base.IsColorAll({
        {358, 350, 3753287},
        {514, 396, 285},
    -- 4号房间
    }), Base.IsColorAll({
        {452, 462, 206664},
        {374, 503, 2174512},
    })
end

function 取色.在手入部屋内()
    return Base.IsColorAll({
        {552, 279, 7830397},
        {745, 443, 13233909},
    })
end

function 取色.检查刀血量()
    local 检查刀HP = function (座标)
        local x, y = table.unpack(座标)
        local 实际血条宽度 = 常量.手入部屋.血条宽度
        while Base.IsColor(x + 8 + 实际血条宽度 - 1, y + 66, 407914) do
            实际血条宽度 = 实际血条宽度 - 1
        end
        return 实际血条宽度 / 常量.手入部屋.血条宽度
    end
    return table.unpack(table.map(常量.手入部屋.刀位置, 检查刀HP))
end

function 取色.检查刀是否已在手入()
    local 检查刀状态 = function (座标)
        local x, y = table.unpack(座标)
        return Base.IsColorAll({
            -- 这里取的点特别靠下所以准确度不受樱吹雪的影响
            {x + 184, y + 50, 15232533},
            {x + 198, y + 50, 15232533},
        })
    end
    return table.unpack(table.map(常量.手入部屋.刀位置, 检查刀状态))
end

function 取色.已选刀()
    return Base.IsColorAll({
        {516, 281, 2175839},
        {707, 282, 2175581},
    })
end

function 取色.已选刀可手入()
    return Base.IsColorAll({
        {712, 477, 8542689},
        {565, 502, 4260561},
    })
end

return 取色
