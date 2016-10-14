--#coding=utf8

--[[
刀_模块化脚本：工具_库 v0.1 by 群内@黒田くん
--]]

-- 通用
function IsColorAll(array)
    for i, item in ipairs(array) do
        if not Base.IsColor(table.unpack(item)) then
            return false
        end
    end
    return true
end

function IsOneOfColors(colors_array, coord)
    for i, color in ipairs(colors_array) do
        local x, y = table.unpack(coord)
        if Base.IsColor(x, y, color) then
            return true
        end
    end
    return false
end

function IsOneOfColorsAll(colors_array, coords_array)
    for i, coord in ipairs(coords_array) do
        if not IsOneOfColors(colors_array, coord) then
            return false
        end
    end
    return true
end

-- 翻页相关
local function HasPagination()
    local colors = {3355443, 5046092}
    local coords = {{354, 550}, {554, 550}}
    return IsOneOfColorsAll(colors, coords)
end

local function IsOnFirstPage()
    return Base.IsColor(354, 550, 3355443)
end

local function IsOnLastPage()
    return Base.IsColor(554, 550, 3355443)
end

local function GoToPrevPage()
end

local function GoToNextPage()
end

local function GoToFirstPage()
end

local function GoToLastPage()
end

Win.Print(HasPagination())
Win.Print(IsOnFirstPage())
Win.Print(IsOnLastPage())

return {
    翻页 = {
        当前界面可以翻页 = HasPagination,
        已在首页 = IsOnFirstPage,
        已在尾页 = IsOnLastPage,
        去上一页 = GoToPrevPage,
        去下一页 = GoToNextPage,
        去首页 = GoToFirstPage,
        去尾页 = GoToLastPage,
    },
}
