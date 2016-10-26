--[[
模块制作：sakura_candy（肝力不足）
--]]

require("API扩展")

local 取色 = {}

function 取色.EquipChoice_IsColorAll()
    return Base.IsColor(908, 232, 7747608)
end

function 取色.等待刀装制作画面()
    while Base.ImageHashContrast(Base.ImageHash(256, 325, 80, 80), "000081FFFFC7E7EF") > 10 do
        Base.Sleep(1000)
    end
end

function 取色.等待刀装制作完毕()
    Base.WaitColor("[[292,215,10321],[265,328,793208],[315,335,859514],[269,458,1324139],[176,324,1334335],[358,345,7961212]]", "刀装制作完毕")
    Base.ClickRectEx(342, 384, 100, 100)
end

return 取色
