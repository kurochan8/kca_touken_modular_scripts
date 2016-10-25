--[[
刀_多合一主体
利用模块化脚本框架打造的全新的多合一肝死队脚本，手入+补刀装+挂远征+出击无限循环，0手入期间特供2333
作者：sakura_candy（肝力不足），黒田くん
--]]

require("API扩展")
创建手入任务 = require("手入")
创建补充刀装任务 = require("补充刀装")
创建远征任务 = require("远征")
创建出阵任务 = require("出阵")
创建任务组 = require("任务组")

---------------------------------------------------------------------
-- 这里是设置区域 一般只需修改这里的值即可

-- 运行时间上限，以秒计算（写个长时间就好，比如14400 = 4小时）
运行时间上限 = 144000
最多进入多少次地图 = 10000
要出击的队伍 = 2

出阵设定 = {
    -- 如果是false，重伤后停止出阵。最保守的做法
    -- 注意！！！！！！千万不要长时间AFK，红脸碎刀是有概率存在的！！！！本婶碎了三把了嘤嘤嘤嘤嘤嘤 ---BY 肝力不足
    重伤后不停止脚本 = false,
    地图 = {6, 1},
    最多进入多少次战斗点 = 50,
    -- 阵型1-6依次为 鱼鳞 横队 雁行 鹤翼 方阵 逆行 如果非1-6数值 则选择2
    索敌失败后使用的阵型 = 2,
    要出击的队伍 = 要出击的队伍,
    是否无视等级提示 = false,
    -- 如果为true 则在出击时地图上有检非标记就会返回出击失败
    遇到检非不进入地图 = false,
    战斗中遇到检非停止脚本 = false,
    战斗中中伤停止脚本 = false,
    战斗中轻伤停止脚本 = false,
}

-- 详细设定可以去 刀_模块化脚本.lua 里参考
手入设定 = {
    可用部屋 = {true, true, false, false},
    手入受伤等级 = "微伤",
    使用加速受伤等级 = nil,
    优先治疗高受伤等级 = false,
}

补刀装设定 = {
    部队号 = 要出击的队伍,
    -- 策略是已经预设好的，详情去 补充刀装.lua 里查看或者自行添加自己想要的策略
    [1] = {
        策略 = "金轻步",
        允许补充任意刀装 = false,
    },
    [2] = {
        策略 = "金银投石",
        允许补充任意刀装 = false,
    },
    [3] = {
        策略 = "金银投石",
        允许补充任意刀装 = false,
    },
    [4] = {
        策略 = "金银投石",
        允许补充任意刀装 = false,
    },
    [5] = {
        策略 = "金银投石",
        允许补充任意刀装 = false,
    },
    [6] = {
        策略 = "金银投石",
        允许补充任意刀装 = false,
    },
}

远征设定 = {
    远征队伍时代 = {nil, {2, 4}, {3, 2}},
}

-- 黑魔法(误)，没什么需求的话建议不要改
全局设定 = {
    -- 当需要检查当前界面是否在某个状态时，多长时间检查一次。（单位：毫秒）
    状态检查间隔 = 200,
    -- 当需要检查当前界面是否在某个状态时，最多检查多久。0为永不言弃（笑）（单位：毫秒）
    状态检查超时 = 2000,
    -- 为了让脚本的行为更自然，在某些操作后附加一些随机的延迟。（单位：毫秒）
    操作延时上限 = 1000,
}

---------------------------------------------------------------------

-- 下面的东西不要乱改了！ 就改上面的设置就行
if IsDmmunlocker() then
    Win.Print("坐标无法对应，脚本无法运行")
end

if 出阵设定.重伤后不停止脚本 then
    Win.Pop("注意！！！！！！千万不要长时间AFK，红脸碎刀是有概率存在的！！！！有守装上！")
end

local 小仓鼠 = 创建任务组({
    创建手入任务(手入设定),
    创建补充刀装任务(补刀装设定),
    创建远征任务(远征设定),
    创建出阵任务(出阵设定),
}, 最多进入多少次地图, 运行时间上限)

小仓鼠.跑呀跑 = 小仓鼠.开始运行

小仓鼠:跑呀跑()

-- Win.Pop("小仓鼠过劳死了T_T呜呜呜呜呜")
Win.Pop("脚本执行完毕！")
