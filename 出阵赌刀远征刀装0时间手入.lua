--就是个大杂烩 BY sakura_candy，群内@肝力不足
--赌刀library：uint
--手入：黑田（超级改良版）& <划掉>我</划掉>
--远征：MaSaXX
--智能拆刀：玄月（疑似弃坑？）
--日课（赌刀框架）：sieben （收日课什么的经常卡所以已经关掉了，记得每天刷新一次游戏刷登陆啊！）
--补刀装：黑田

--基本上是黑田的了，只是contribute一下

require("刀_模块化脚本")

---------------------------------------------------------------------
--这里是设置区域 一般只需修改这里的值即可

--远征开关
--要远征的话需要在TouKen_远征_0.6.0_mod.lua和TouKen_远征_0.6.0.lua 修改设置和开关，一定要一致
远征开关 = true

--赌刀开关，同上，在Touken_Smith.lua里面设置你要的配方，赌刀位。现在是
smith = false
--运行时间上限，以秒计算（写个长时间就好，怕赌刀出4h可是拆刀脚本出检测错误不小心拆了，可以用14400，4小时）
stop_timer = 144000

--手入床位，最低1，最高4，如果你只氪了4号位没氪3号…… 既然都氪了4号位为啥不氪3号呢？（这种情况放4应该也可以吧）
bed_count = 4

--如果是true，重伤后不停止脚本。一定一定要和后面的“创建手入任务”和“创建补充刀装任务”一起用。
--注意！！！！！！千万不要长时间AFK，红脸碎刀是有概率存在的！！！！本婶碎了三把了嘤嘤嘤嘤嘤嘤 ---BY 肝力不足
--如果是false，重伤后停止出阵。最保守的做法
重伤后直接手入继续肝 = true

--地图
map_id = {2,4}

max_count = 10000
--最多进入多少次地图

max_battle_count = 50
--最多进入多少次战斗点

formation = 2
--索敌失败后使用的阵型
--阵型1-6依次为 鱼鳞 横队 雁行 鹤翼 方阵 逆行 如果非1-6数值 则选择2

team_id = 1
--出击的队伍(1-4)

--详细设定可以去 刀_模块化脚本.lua 里参考
手入和补刀装 = 创建任务组({
    创建手入任务({
        可用部屋 = {true, true, false, false},
        手入受伤等级 = "微伤",
        使用加速受伤等级 = nil,
        优先治疗高受伤等级 = false,
    }),
    创建补充刀装任务({
        部队号 = 1,
		--策略是已经预设好的，详情去 补充刀装.lua 里查看或者自行添加自己想要的策略
        [1] = {
            策略 = "轻骑投石轻步",
            允许补充任意刀装 = true,
        },
        [2] = {
            策略 = "轻骑投石轻步",
            允许补充任意刀装 = true,
        },
        [3] = {
            策略 = "轻骑投石轻步",
            允许补充任意刀装 = true,
        },
        [4] = {
            策略 = "轻骑投石轻步",
            允许补充任意刀装 = true,
        },
        [5] = {
            策略 = "轻骑投石轻步",
            允许补充任意刀装 = true,
        },
        [6] = {
            策略 = "轻骑投石轻步",
            允许补充任意刀装 = true,
        },
    }),
}, 1)


ignore_lv_msg = false
--是否无视等级提示

遇到检非不进入地图 = false
--好吧 不知道怎么翻译 直接用中文变量了
--如果为true 则在出击时地图上有检非标记就会返回出击失败

战斗中遇到检非停止脚本 = false
--道中遇到检非打不打，false=不停止 true=停止

战斗中中伤停止脚本 = false
--false=不停止 true=停止

战斗中轻伤停止脚本 = false
--false=不停止 true=停止

Base.SetConfig("Sleep+?", 331)
---------------------------------------------------------------------

--下面的东西不要乱改了！ 就改上面的设置就行
function IsColorAll(array)
    n = 0
    ok = 0
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

function IsDmmunlocker() --判断界面是否正确
    array = {};count = {}
    array = {[0]=17,19,16777215};count[0] = array
    array = {[0]=52,15,16777215};count[1] = array
    array = {[0]=105,16,16777215};count[2] = array
    array = {[0]=165,16,16777215};count[3] = array
    return IsColorAll(count)
end

if 重伤后直接手入继续肝 then
    Win.Pop("注意！！！！！！千万不要长时间AFK，红脸碎刀是有概率存在的！！！！有守装上！")
end

local startT = os.clock()
Win.Print(string.format("Start time %.2f\n", startT))

手入和补刀装:开始运行()

if IsDmmunlocker() == false then
    mode = 0
    if 战斗中遇到检非停止脚本 == true then
        mode = mode + 4
    end
    if 战斗中中伤停止脚本 == true then
        mode = mode + 1
    end
    if 战斗中轻伤停止脚本 == true then
        mode = mode + 2
    end

    for n = 1, max_count do --循环次数
        Win.Print(string.format("Current time %.2f\n", os.clock()))
        if  (os.clock() - startT) > stop_timer then
            Win.Print("时间到，停止循环")
            break
        end

        a = "开始第:%d次"
        Win.Print(a:format(n))

        if 远征开关 == true then
            Win.Print("远征")
            package.loaded["TouKen_Expedition_0_6_0_mod"] = nil
            require("TouKen_Expedition_0_6_0_mod")

        end
        if smith == true then

            Win.Print("赌刀")
            package.loaded["Touken_Smith"] = nil
            require("Touken_Smith")
        end

        EnterHome()

        if Touken.出阵(map_id[1],map_id[2],遇到检非不进入地图) == false then
            Win.Print('无法出阵退出')
            break --无法出阵
        end

        --战斗
        ret = Tou.Battle(max_battle_count, formation, mode, team_id, ignore_lv_msg)
        if ret > 0 then
            if 重伤后直接手入继续肝 then --加速手入，只加速重伤刀
                Win.Print('重伤，用手入把队员拉起来') --发现重伤了
                status = 手入和补刀装:开始运行()
                if status < 0 then
                    Win.Print('手入补刀装任务出错，中断脚本')  -- 比如没有空余手入位
                    break
                end
            else
                Win.Print('重伤中断脚本') --发现重伤了
                break
            end
        end

        if ret == -1 then
            Win.Print('检非中断脚本') --发现检非

            Base.ReLoad()
            while Base.IsColor(468,453,7747046) == false
            do
             Base.Click(468,453)
             Base.Sleep(2000,true)
            end
            Base.Click(468,453)
        end

        if ret == -2 then
            Win.Print('超过等级 中断脚本') --发现检非
            break
        end

        if ret == 0 then
            Win.Print('既然是0时间手入那就大家都去检查一遍再开始下一轮的肝') -- 比如没有空余手入位
            status = 手入和补刀装:开始运行()
			if status < 0 then
				Win.Print('手入补刀装任务出错，中断脚本')  -- 比如没有空余手入位
				break
			end
        end

    end
else
    Win.Print('检测到游戏内存在空白，坐标无法对应，脚本无法运行！') --发现重伤了
end

Win.Pop('脚本执行完毕！')
