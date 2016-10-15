--[[
��_ģ�黯�ű� v0.1 by Ⱥ��@�\�勞��
API��չ: ��ԭ��API�Ļ����������µĹ��ܣ�����һЩ���õĺ���Ҳ˳���������
--]]

if table.map == nil then
    function table.map(array, func)
        local new_array = {}
        for i, v in ipairs(array) do
            new_array[i] = func(v)
        end
        return new_array
    end
end

if Base.IsColorAll == nil then
    function Base.IsColorAll(array)
        for i, item in pairs(array) do
            if not Base.IsColor(table.unpack(item)) then
                return false
            end
        end
        return true
    end
end

if Base.IsOneOfColors == nil then
    function Base.IsOneOfColors(coord, colors_array)
        for i, color in pairs(colors_array) do
            local x, y = table.unpack(coord)
            if Base.IsColor(x, y, color) then
                return true
            end
        end
        return false
    end
end

if Base.IsOneOfColorsAll == nil then
    function Base.IsOneOfColorsAll(coords_array, colors_array)
        for i, coord in pairs(coords_array) do
            if not Base.IsOneOfColors(coord, colors_array) then
                return false
            end
        end
        return true
    end
end

if �ȴ� == nil then
    function �ȴ�(...)
        local arg = table.pack(...)
        local is_simple_function = (#arg == 1)
        local timer = 0
        while not (is_simple_function and arg[1]() or arg[1][arg[2]](arg[1])) do
            if �趨.״̬��鳬ʱ > 0 and timer >= �趨.״̬��鳬ʱ then
                return false
            end
            timer = timer + �趨.״̬�����
            Base.Sleep(�趨.״̬�����)
        end
        return true
    end
end

if ���ٲ��� == nil then
    function ���ٲ���(obj)
        local inspect = require("inspect")
        for key, item in pairs(obj) do
            if type(item) == "function" then
                Win.Print("������ " .. key .. " ���: " .. inspect({item()}))
            end
        end
    end
end
