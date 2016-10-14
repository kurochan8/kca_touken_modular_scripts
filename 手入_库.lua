--#coding=utf8

--[[
刀_模块化脚本：手入 v0.1 by 群内@黒田くん
基于手入脚本v1.2（取色part） by 论坛@sakura_candy，群内@肝力不足
--]]

require("工具_库")

function Hospital_IsColorAll()
	count = {}
	table.insert(count,0,{[0]=165,106,14220285})
	table.insert(count,0,{[0]=732,256,10740205})
	return IsColorAll(count)
end

function Bed_IsEmpty(n)
	if n == 1 then
		count = {}
		table.insert(count,0,{[0]=440,138,9015441})
		table.insert(count,0,{[0]=361,104,4016202})
		table.insert(count,0,{[0]=541,174,1120797})
		return IsColorAll(count)
	elseif n==2 then
		count = {}
		table.insert(count,0,{[0]=362,221,4147788})
		table.insert(count,0,{[0]=451,256,16777215})
		table.insert(count,0,{[0]=527,283,1450532})
		return IsColorAll(count)
	elseif n==3 then
		count = {}
		table.insert(count,0,{[0]=358,350,3753287})
		table.insert(count,0,{[0]=514,396,285})
		return IsColorAll(count)
	elseif n==4 then
		count = {}
		table.insert(count,0,{[0]=452,462,206664})
		table.insert(count,0,{[0]=374,503,2174512})
		return IsColorAll(count)
	else
		Win.Print("非法手入室番号")
	end
end

function InBed_isColorAll()
	count = {}
	table.insert(count,0,{[0]=552,279,7830397})
	table.insert(count,0,{[0]=745,443,13233909})
	return IsColorAll(count)
end

function SelectedSword_IsColorAll()
	Win.Print("SelectedSword_IsColorAll")
	count = {}
	table.insert(count,0,{[0]=516,281,2175839})
	table.insert(count,0,{[0]=707,282,2175581})
	return IsColorAll(count)
end

function CurrentSwordHealable()
	count = {}
	table.insert(count,0,{[0]=712,477,8542689})
	table.insert(count,0,{[0]=565,502,4260561})
	return IsColorAll(count)
end

function Wound_isLight()
	count = {}
	table.insert(count,0,{[0]=731,104,50926})
	return IsColorAll(count)
end

function Wound_isHospitalized()
	count = {}
	table.insert(count,0,{[0]=731,104,15232533})
	return IsColorAll(count)
end

function Wound_isDying()
	count = {}
	table.insert(count,0,{[0]=731,104,131823})
	return IsColorAll(count)
end

function Wound_isMedium()
	count = {}
	table.insert(count,0,{[0]=731,104,32511})
	return IsColorAll(count)
end

--1微伤轻伤，2中伤，3重伤，0手入，-1嘛事儿没有
function GetCurrentSwordStatus(x, y)
	color = Base.GetColor(731,104)
	if color == 50926 then
		Win.Print("轻伤")
		return 1

	elseif color == 32511 then
		Win.Print("中伤")
		return 2

	elseif color == 131823 then
		Win.Print("重伤")
		return 3

	elseif color == 15232533 then
		Win.Print("已在手入")
		return 0
	elseif CurrentSwordHealable() then
		Win.Print("看不出什么伤！虽然-1hp也这样，不过保险起见，既然能治就治")
		return 999
	else
		Win.Print("无伤")
		return -1
	end
end
