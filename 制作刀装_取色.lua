--[[
模块化移植：sakura_candy（肝力不足）
取色（自动日课脚本）：sieben
--]]

require("API扩展")

local 取色 = {}

function 取色.EquipChoice_IsColorAll()
    return Base.IsColor(908,232,7747608)
end

return 取色