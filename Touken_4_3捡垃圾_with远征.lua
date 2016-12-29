--本体BY uint(?) 合体BY 肝力不足
--请放到多合一的文件夹里使用
--如果上个出阵是在活动图请打一下1-1

--/**********************************可设置内容**************************************/
--循环操作次数(进入地图至退出地图为1次)
max_count = 300;

--索敌失败后使用的阵型
--阵型1-6依次为 鱼鳞 横队 雁行 鹤翼 方阵 逆行 如果非1-6数值 则选择2
formation = 2;

--启用操作间长延时,建议在夜间挂机时开启
longDelayEnabled = false;

--操作间长延时长度,单位为秒
longDelayDuration = 28;


远征设定 = {
    -- 远征队伍的时代选择，从左到右分别是2队，3队，4队。如果哪个队伍放nil就是是不远征
    远征队伍时代 = {nil, {1,1}, {2, 2}},
	--远征队伍时代 = {{1,1},nil,nil},

}

--/*********************************************************************************/

require("API扩展") 
远征任务 = require("远征")
local 通用 = require("通用")
local 本丸 = 通用.本丸


expedition = 远征任务(远征设定)

--战斗完成后进击
PROC_TYPE_ONSLAUGHT = 1;

--战斗完成后撤退
PROC_TYPE_RETREAT = 2;

--战斗完成后不作任何操作
PROC_TYPE_IGNORE = 0;

function IsColorAll(array)
	n=0
	ok=0
	while(array[n] ~= nil)
	do
		if Base.IsColor(array[n][0],array[n][1],array[n][2])==true then
			ok = ok + 1
		end
		n= n+1
	end
	
	if ok==n then
		return true
	else
		return false
	end
end

function Route_IsColorAll()
    array = {};count = {};
	
    array = {[0]=403,434,14741750}; count[0] = array; --判断D点是否有旗

    return IsColorAll(count)
end

function RouteChoice_IsColorAll()
    array = {};count = {};
	
    array = {[0]=883,249,2377040}; count[0] = array; --判断D点是否有旗

    return IsColorAll(count)
end

--重伤检测
function CheckSeriouslyInjured()
	i = 0;
	result = 0;
	for i = 1 , 6 do
    	if Base.IsColor(195,190+67*(i-1),131823) then
			--哪一把刀重伤,就把对应的二进制位置1.
			--相当于result = result | 1 << (i - 1)
            --|(MSB) 8  7  6  5  4  3  2  1 (LSB)|<-二进制位
            --|      -  -  6  5  4  3  2  1      |<-刀剑在队伍中位置
            --例如第二把与第四把刀重伤,则返回0b00001010.
            --留给往后扩展用的,现在没有什么卵用.
			result = result + 2 ^ (i - 1)
		end
	end
	return result;
end 

function IsFormationControl()   --检测阵型选择界面
    count = {};
	
	table.insert(count,0,{[0]=446,25,16776959}); 
	table.insert(count,0,{[0]=529,29,16711422});
	table.insert(count,0,{[0]=52,546,659210});
	table.insert(count,0,{[0]=906,464,3618345}); 

    return IsColorAll(count)
end

--是否在进击撤退画面
function IsProcessControl()
	count = {};
	
	table.insert(count,0,{[0]=587,294,16777215}); 
	table.insert(count,0,{[0]=651,309,16777215}); 
	table.insert(count,0,{[0]=806,294,16777215}); 
	table.insert(count,0,{[0]=867,301,16777215}); 
	
    return IsColorAll(count)
end

function IsGameFrameInvalid() --判断界面是否不正确
	array = {};count = {}
	
	array = {[0]=17,19,16777215}
	count[0] = array
	array = {[0]=52,15,16777215}
	count[1] = array
	array = {[0]=105,16,16777215}
	count[2] = array
	array = {[0]=165,16,16777215}
	count[3] = array

	return IsColorAll(count)
end

function IsHome() --判断是否在本丸
	count = {}
	
	table.insert(count,0,{[0]=71,47,3700737});
	table.insert(count,0,{[0]=52,359,3768321}); 
	table.insert(count,0,{[0]=50,552,2116608});
	table.insert(count,0,{[0]=875,71,2050817});
	table.insert(count,0,{[0]=940,68,2117633});

	return IsColorAll(count)
end


--/**********************/
--/*判断对话框是否正弹出*/
--/* ****************** */
--/*  返回值:对话框是否 */
--/*  弹出              */
--/**********************/
function IsMsgbox()
    return (Base.ImageHashContrast(Base.ImageHash(252,153,100,50),"007F7F7F7E7F7F7F") < 10);
end

--/**********************/
--/*     处理对话框     */
--/* ****************** */
--/*   option:是或否    */
--/* 单按钮对话框可任意 */
--/*   返回值:是否成功  */
--/**********************/
function ProcessMsgbox(option)
    --操作计数器
    time = 0;

    --并没有对话框，立即返回
    if not IsMsgbox() then
        return false;
    end

    --循环点击直到对话框消失，限时60s（每500ms计数器加一）
    while IsMsgbox() and time < 120 do
        --是否有"否"按钮
        if Base.ImageHashContrast(Base.ImageHash(536,324,80,30),"FFFFFB7F7B4B0100") < 10 then
                if option then
                    Base.ClickRect(386,338);
                else
                    Base.ClickRect(571,338);
                end
        else
            Base.ClickRect(486,338);
        end
        Base.Sleep(500);
        time = time + 1;
    end

    if time < 120 then
        return true;
    else
        return false;
    end
end

function FormationChoice(default)
	--用来标记有利阵型
	positiveFormation = 0;
	
	for x = 0, 2 do
		for y = 0, 1 do
			if Base.IsColorEx(117 + (x * 262), 146 + (y * 186), 66269, 8) then
				--将x/y位置换算成两位数,十位为x,个位为y,范围x[1,3],y[1,2].
				Base.Print("x=" .. x .. "  y=" .. y);
				positiveFormation = (x + 1) * 10 + (y + 1);
				Base.Print("fm=" .. positiveFormation);
				break;
			end
		end
	end
	
	--索敌失败
	if positiveFormation == 0 then
		--直接按照传入的参数选择
		if default == 1 then
            Base.ClickRectEx(213,167,140,80)
        elseif default == 2 then
            Base.ClickRectEx(477,167,140,80)
        elseif default == 3 then
            Base.ClickRectEx(740,167,140,80)
        elseif default == 4 then
            Base.ClickRectEx(215,352,140,80)
        elseif default == 5 then
            Base.ClickRectEx(479,353,140,80)
        elseif default == 6 then
            Base.ClickRectEx(741,353,140,80)
        end
		Base.Print("索敌失败");
	else
		--将两位数还原成x与y,再乘以基础坐标并加上一点偏移,使实际坐标位于按钮中央.
		xPos = 117 + ((positiveFormation / 10 % 10) - 1) * 262 + 100;
		yPos = 146 + ((positiveFormation % 10) - 1) * 186 + 20;
		Base.ClickRect(xPos, yPos, 30);
	end
end

--/************************/
--/*       处理战斗       */
--/*会忽略资源点(一直单击)*/
--/* *******************  */
--/*    processType:战斗  */
--/*       完毕后操作     */
--/*   1=按进击 2=按撤退  */
--/*   其他=不作任何操作  */
--/*  返回-1为跳回到本丸  */
--/*  返回>128为有刀重伤  */
--/************************/
function ProcessBattle(processType)
	Win.Print("等待选择阵型...");
	
    while not IsFormationControl() do
		Base.ClickRect(471,547,50);
        Base.Sleep(1000, true);
 
		if IsHome() then
			return -1;
		end
    end
	
	Base.Sleep(200, true);
	
	FormationChoice();
	Base.Print("阵型选择完成,战斗开始...");
	
	while not IsProcessControl() do
		Base.ClickRect(268,303,50)
        Base.Sleep(1000, true)
    end
	
	Base.Sleep(800);
	
	--检查重伤
	injury = CheckSeriouslyInjured();
	if injury ~= 0 then
		--先撤退
		Base.ClickRect(827,271,25);
		--返回重伤刀数据,第8位置1
		return injury + 128;
	end
	
	while IsProcessControl() do 
		if processType == 1 then
			--进击
			Base.ClickRect(613,275,25);
		elseif processType == 2 then
			--撤退
			Base.ClickRect(827,271,25);
		else
			--忽略
			break;
		end
	end
	
	return 0;
end

--/***main()***/
Base.SetConfig("Sleep+?", 1500);
if IsGameFrameInvalid() then
	error("错误:Flash未提取!");
end


-- 黑魔法(误)，没什么需求的话建议不要改
全局设定 = {
    -- 当需要检查当前界面是否在某个状态时，多长时间检查一次。（单位：毫秒）
    状态检查间隔 = 200,
    -- 当需要检查当前界面是否在某个状态时，最多检查多久。0为永不言弃（笑）（单位：毫秒）
    状态检查超时 = 2000,
    -- 为了让脚本的行为更自然，在某些操作后附加一些随机的延迟。（单位：毫秒）
    操作延时上限 = 600,
}

for n = 1, max_count do --循环次数
    本丸.回本丸()
    expedition.执行(expedition)
	Win.Print("循环操作:第" .. n .. "次,共" .. max_count .. "次")
	
	if not Touken.出阵(4,3,HaltIfKebiishiFound) then 
		error("错误:地图已启用检非违使!");
	end
	
	Base.Sleep(2000);
	
	--判断等级超出对话框出现
	if IsMsgbox() then
		ProcessMsgbox(false);
		error("错误:队伍平均等级超出限制!");
	end
	
	Base.Click(626,501);
	Base.Sleep(500, true);
	
	for i =1, 3 do
		Base.Print("前3次战斗:正在进行第" .. i .. "次");
		result = ProcessBattle(PROC_TYPE_ONSLAUGHT);
           if result > 0 then
               error("错误:有刀剑重伤!");
           end
	end
			
	Win.Print('三战结束，等待确认路线')
	while not RouteChoice_IsColorAll() do
       	Base.Sleep(1000)
   	end
	
	if Route_IsColorAll() then		
		max_battle_count = 3;
		Win.Print('进军路线确认为下方,继续进击3次');
		else
		max_battle_count = 1;
		Win.Print('进军路线确认为上方,继续进击1次');
	end
	
	for i = 1, max_battle_count do
		Base.Print("后续战斗:第" .. i .. "次,共" .. max_battle_count .. "次");
		--最后一次战斗完成后撤退
		if i ~= max_battle_count then
			Base.Print("此次完成后进击");
			result = ProcessBattle(PROC_TYPE_ONSLAUGHT);
		else
			Base.Print("此次完成后撤退");
			result = ProcessBattle(PROC_TYPE_RETREAT);
		end
		--退回到本丸,直接进行下一次
		if result == -1 then
			Base.Print("退回本丸,此次地图战斗结束");
			break;
        elseif result > 0 then
               error("错误:有刀剑重伤!");
		end
	end
	
	if longDelayEnabled then
		Base.Print("操作间长延时...");
		time = 0;
		while time < longDelayDuration do
			Base.Sleep(1000);
			time = time + 1;
			if time % 60 == 0 then
				Base.Print("已等待" .. time / 60 .. "min");
			end
		end
		Base.Print("偏移延迟...(1-3min)");
		Base.SetConfig("Sleep+?", 180000);
		Base.Sleep(60000, true);
		Base.SetConfig("Sleep+?", 1500);
	else
		Base.Sleep(2000, true);
	end
end
