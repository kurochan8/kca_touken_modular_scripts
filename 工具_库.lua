--[[
刀_模块化脚本：工具_库 v0.1 by 群内@黒田くん
--]]

-- 通用
function IsColorAll(array)
	for item in array do
		if Base.IsColor(item[0], item[1], item[2]) == false then
			return false
		end
	end
	return true
end

function IsOneOfColors(colors_array, coord)
	for color in colors_array do
		if Base.IsColor(coord[0], coord[1], color) == true then
			return true
		end
	end
	return false
end

function IsOneOfColorsAll(colors_array, coords_array)
	for coord in coords_array do
		if IsOneOfColors(colors_array, coord) == false then
			return false
		end
	end
	return true
end

-- 翻页相关
function 当前界面可以翻页()
	local colors = {3355443, 5046092}
	local coords = {{354, 550}, {554, 550}}
	return IsOneOfColorsAll（colors, coords)
end

function 已在首页()
	return Base.IsColor(354, 550, 3355443)
end

function 已在尾页()
	return Base.IsColor(554, 550, 3355443)
end

function 去下一页（）
end

function 去上一页()
end

function 去首页（）
end

function 去尾页()
end

Win.Print(当前界面可以翻页())