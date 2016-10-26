--[[
刀_模块化脚本
任务组：用于控制多个任务的串联和循环运行
作者：黒田くん
--]]

require("API扩展")

local 任务组 = {}

function 任务组.开始运行(self)
    local 任务开始时间 = os.time()
    Win.Print("任务组：开始运行")
    local return_code = 0
    for i = 1, self.循环次数, 1 do
        local 当前时间 = os.time()
        if self.超时 > 0 and 当前时间 - 任务开始时间 > self.超时 then
            Win.Print("任务组：执行超时，结束运行")
            return -1
        end

        Win.Print("任务组：开始执行第" .. tostring(i) .. "次循环")

        for j = 1, #self.任务序列, 1 do
            if type(self.任务序列[j]) == "function" then
                return_code = self.任务序列[j]()
            elseif self.任务序列[j]["执行"] and type(self.任务序列[j]["执行"]) == "function" then
                return_code = self.任务序列[j]["执行"](self.任务序列[j])
            else
                Win.Print("任务组：检测到无效任务，中止运行")
                Win.Print("任务组：" .. require("inspect")(self.任务序列[j]))
                return -1
            end
            --如果任何一个任务出错了就直接返回
            if return_code < 0 then
                Win.Print("任务组：任务出错，中止运行，错误代码"..return_code)
                return return_code
            end

        end
    end
    Win.Print("任务组：到达指定循环次数，结束运行")
    return return_code
end

function 任务组:new(任务序列, 循环次数, 超时)
    local instance = {}
    setmetatable(instance, {__index = 任务组})
    Base.SetConfig("Sleep+?", 全局设定.操作延时上限)
    instance.任务序列 = 任务序列
    instance.循环次数 = 循环次数 or 2147483647
    instance.超时 = 超时 or 86400
    return instance
end

setmetatable(任务组, {__call = 任务组.new})

return 任务组
