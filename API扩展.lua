--[[
��_ģ�黯�ű�
API��չ����ԭ��API�Ļ����������µĹ��ܣ�����һЩ���õĺ���Ҳ˳���������
���ߣ��\�勞��
--]]

if table.key_of == nil then
    function table.key_of(array, value)
        for k, v in pairs(array) do
            if v == value then
                return k
            end
        end
        return nil
    end
end

if table.index_of == nil then
    function table.index_of(array, value)
        for i, v in ipairs(array) do
            if v == value then
                return i
            end
        end
        return 0
    end
end

if table.map == nil then
    function table.map(array, func)
        local new_array = {}
        for i, v in ipairs(array) do
            new_array[i] = func(v)
        end
        return new_array
    end
end

if table.filter == nil then
    function table.filter(array, func)
        local new_array = {}
        for i, v in ipairs(array) do
            if func(v) then
                table.insert(new_array, v)
            end
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

if Base.ClickRectEx2 == nil then
    -- ����������ѡ�񳤷�������������������һ��
    function Base.ClickRectEx2(x1, y1, x2, y2)

        -- ��������
        if x2 < x1 then
            local temp = x2
            x2 = x1
            x1 = temp
        end
        if y2 < y1 then
            local temp = y2
            y2 = y1
            y1 = temp
        end

        local width = x2 - x1
        local height =  y2 - y1

        -- �������Ϊ2�ı���
        width = math.floor(width / 2) * 2
        height = math.floor(height / 2) * 2

        return Base.ClickRectEx(x1 + width / 2, y1 + height / 2, width, height)
    end
end

if �ȴ� == nil then
    function �ȴ�(...)
        local arg = table.pack(...)
        local timer = 0
        local check_func = nil

        if type(arg[1]) == "function" then
            check_func = arg[1]
            table.remove(arg, 1)
        else
            check_func = arg[1][arg[2]]
            table.remove(arg, 2)
        end

        while not check_func(table.unpack(arg)) do
            if ȫ���趨.״̬��鳬ʱ > 0 and timer >= ȫ���趨.״̬��鳬ʱ then
                return false
            end
            timer = timer + ȫ���趨.״̬�����
            Base.Sleep(ȫ���趨.״̬�����)
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

if ���ٲ���2 == nil then
    function ���ٲ���2(func, range)
        local result = {}
        for i = 1, range, 1 do
            table.insert(result, func(i))
        end
        return table.unpack(result)
    end
end

if IsDmmunlocker == nil then
    --�жϽ����Ƿ���ȷ
    function IsDmmunlocker()
        return Base.IsColorAll({
            {17, 19, 16777215},
            {52, 15, 16777215},
            {105, 16, 16777215},
            {165, 16, 16777215},
        })
    end
end
