--[[
ģ��������sakura_candy���������㣩
--]]

require("API��չ")

local ȡɫ = {}

function ȡɫ.EquipChoice_IsColorAll()
    return Base.IsColor(908, 232, 7747608)
end

function ȡɫ.�ȴ���װ��������()
    while Base.ImageHashContrast(Base.ImageHash(256, 325, 80, 80), "000081FFFFC7E7EF") > 10 do
        Base.Sleep(1000)
    end
end

function ȡɫ.�ȴ���װ�������()
    Base.WaitColor("[[292,215,10321],[265,328,793208],[315,335,859514],[269,458,1324139],[176,324,1334335],[358,345,7961212]]", "��װ�������")
    Base.ClickRectEx(342, 384, 100, 100)
end

return ȡɫ
