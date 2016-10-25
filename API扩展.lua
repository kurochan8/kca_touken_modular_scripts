--[[
刀_模块化脚本
API扩展：在原有API的基础上增加新的功能，还有一些常用的函数也顺便放这里了
作者：黒田くん
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
    -- 根据两个点选择长方形区域并且随机点击其中一点
    function Base.ClickRectEx2(x1, y1, x2, y2)

        -- 修正座标
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

        -- 修正宽高为2的倍数
        width = math.floor(width / 2) * 2
        height = math.floor(height / 2) * 2

        return Base.ClickRectEx(x1 + width / 2, y1 + height / 2, width, height)
    end
end

if 等待 == nil then
    function 等待(...)
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
            if 全局设定.状态检查超时 > 0 and timer >= 全局设定.状态检查超时 then
                return false
            end
            timer = timer + 全局设定.状态检查间隔
            Base.Sleep(全局设定.状态检查间隔)
        end
        return true
    end
end

if 快速测试 == nil then
    function 快速测试(obj)
        local inspect = require("inspect")
        for key, item in pairs(obj) do
            if type(item) == "function" then
                Win.Print("函数： " .. key .. " 结果: " .. inspect({item()}))
            end
        end
    end
end

if 快速测试2 == nil then
    function 快速测试2(func, range)
        local result = {}
        for i = 1, range, 1 do
            table.insert(result, func(i))
        end
        return table.unpack(result)
    end
end

if IsDmmunlocker == nil then
    --判断界面是否正确
    function IsDmmunlocker()
        return Base.IsColorAll({
            {17, 19, 16777215},
            {52, 15, 16777215},
            {105, 16, 16777215},
            {165, 16, 16777215},
        })
    end
end
