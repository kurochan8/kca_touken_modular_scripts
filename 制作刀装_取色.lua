--[[
模块制作：sakura_candy（肝力不足）
--]]

require("API扩展")

local 取色 = {}

function 取色.EquipChoice_IsColorAll()
    return Base.IsColor(908, 232, 7747608)
end

function 取色.EquipMakeTenFinished()
    return Base.IsColorAll(
                {{289,275,2381689},
                {188,275,1387120},
                {387,279,1386602},
                {292,127,4081447},
                {272,388,2452862},
                {396,426,1789557}}
                )
end

function 取色.EquipMakeOneFinished()
    return Base.ImageHashContrast(Base.ImageHash(262, 135, 50, 50), "3CDDDFD587800060") < 10
end

function 取色.等待刀装制作画面()
    while Base.ImageHashContrast(Base.ImageHash(256, 325, 80, 80), "000081FFFFC7E7EF") > 10 do
        Base.Sleep(1000)
    end
end

function 取色.等待刀装制作完毕()
    while not 取色.EquipMakeTenFinished() and not 取色.EquipMakeOneFinished() do
		Base.Print("等待刀装制作完毕")
		Base.Sleep(1000)
	end
    Base.ClickRectEx(342, 384, 100, 100)
end

return 取色
