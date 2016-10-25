--[[
刀_模块化脚本
远征_取色：远征相关的取色函数的集合体
原作者：MaSaXX
模块化作者：sakura_candy（肝力不足），黒田くん
--]]

require("API扩展")

local 取色 = {}

function 取色.TeamList_IsColorAll()
    return Base.IsColor(910, 149, 1973923)
end

function 取色.TeamFix_TeamChoiceButton_IsColorAll()
    return Base.IsColor(677, 524, 93185)
end

function 取色.ExpChoice_IsColorAll()
    return Base.IsColor(744, 326, 12018204)
end

function 取色.AgeOne_IsColorAll()
    return Base.IsColor(202, 186, 10709221)
end

function 取色.TeamChoice_IsColorAll()
    return Base.IsColor(608, 104, 11645286)
end

function 取色.TeamChoiceGreen_IsColorAll()
    return Base.IsColor(677, 523, 2589479)
end

function 取色.TeamChoiceERROR_IsColorAll()
    return Base.IsColor(571, 551, 3687415)
end

return 取色
