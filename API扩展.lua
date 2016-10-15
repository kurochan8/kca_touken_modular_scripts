--[[
刀_模块化脚本 v0.1 by 群内@黒田くん
API扩展: 在原有API的基础上增加新的功能，还有一些常用的函数也顺便放这里了
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

if 等待 == nil then
    function 等待(...)
        local arg = table.pack(...)
        local is_simple_function = (#arg == 1)
        local timer = 0
        while not (is_simple_function and arg[1]() or arg[1][arg[2]](arg[1])) do
            if 设定.状态检查超时 > 0 and timer >= 设定.状态检查超时 then
                return false
            end
            timer = timer + 设定.状态检查间隔
            Base.Sleep(设定.状态检查间隔)
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
