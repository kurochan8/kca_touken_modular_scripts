--[[
ģ��������sakura_candy���������㣩
--]]

require("API��չ")

local ȡɫ = {}

function ȡɫ.EquipChoice_IsColorAll()
    return Base.IsColor(908, 232, 7747608)
end

function ȡɫ.EquipMakeTenFinished()
    return Base.IsColorAll(
                {{289,275,2381689},
                {188,275,1387120},
                {387,279,1386602},
                {292,127,4081447},
                {272,388,2452862},
                {396,426,1789557}}
                )
end

function ȡɫ.EquipMakeOneFinished()
    return Base.ImageHashContrast(Base.ImageHash(262, 135, 50, 50), "3CDDDFD587800060") < 10
end

function ȡɫ.�ȴ���װ��������()
    while Base.ImageHashContrast(Base.ImageHash(256, 325, 80, 80), "000081FFFFC7E7EF") > 10 do
        Base.Sleep(1000)
    end
end

function ȡɫ.�ȴ���װ�������()
    while not ȡɫ.EquipMakeTenFinished() and not ȡɫ.EquipMakeOneFinished() do
		Base.Print("�ȴ���װ�������")
		Base.Sleep(1000)
	end
    Base.ClickRectEx(342, 384, 100, 100)
end

return ȡɫ
