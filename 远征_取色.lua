--[[
ģ�黯��ֲ��sakura_candy���������㣩
Զ��_ȡɫ��MaSaXX
--]]

local ȡɫ = {}
function ȡɫ.IsColorAll(array)
    n=0
    ok=0
    while(array[n] ~= nil)
    do
        if Base.IsColor(array[n][0],array[n][1],array[n][2])==true then
            ok = ok + 1
        end
        n= n + 1
    end
    
    if ok == n then
        return true
        else
        return false
    end
end

function ȡɫ.TeamList_IsColorAll()
    array = {};count = {};
    
    array = {[0]=910,149,1973923}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.TeamFix_TeamChoiceButton_IsColorAll()
    array = {};count = {};
    
    array = {[0]=677,524,93185}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.Home_IsColorAll()
    array = {};count = {};
    
    --array = {[0]=908,66,3498264}; count[0] = array;
    array = {[0]=53,72,11397105}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.Mail_IsColorAll()
    array = {};count = {};
    
    array = {[0]=730,157,6931435}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.SwordList_IsColorAll()
    array = {};count = {};
    
    array = {[0]=853,556,353499}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.Team_IsColorAll()
    array = {};count = {};
    
    array = {[0]=909,151,723863}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.Attack_IsColorAll()
    array = {};count = {};
    array = {[0]=218,179,10178876}; count[0] = array;
    
    return IsColorAll(count)
end

function ȡɫ.ExpChoice_IsColorAll()
    array = {};count = {};
    
    --array = {[0]=409,116,9454599}; count[0] = array; -�ɰ����
    array = {[0]=744,326,12018204}; count[0] = array;
    
    return IsColorAll(count)
end

function ȡɫ.AgeOne_IsColorAll()
    array = {};count = {};
    
    array = {[0]=202,186,10709221}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.RE_IsColorAll()  --����ȡɫ(���Ʒ���)
    array = {};count = {};
    
    array = {[0]=679,527,263305}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.TeamChoice_IsColorAll()
    array = {};count = {};
    
    array = {[0]=608,104,11645286}; count[0] = array;
    
    return IsColorAll(count)
end

function ȡɫ.TeamChoiceERROR_IsColorAll()
    array = {};count = {};
    
    array = {[0]=571,551,3687415}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.Res_IsColorAll()  --���ս��ҳ����
    array = {};count = {};
    
    array = {[0]=29,32,16187147}; count[0] = array;
    array = {[0]=258,101,15265546}; count[1] = array;

    return IsColorAll(count)
end

function ȡɫ.GoHome_IsColorAll()
    array = {};count = {};
    
    array = {[0]=680,511,2960685}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.TeamChoiceGreen_IsColorAll()
    array = {};count = {};
    
    array = {[0]=677,523,2589479}; count[0] = array;

    return IsColorAll(count)
end

function ȡɫ.Time_ID(TimeID)  
    if TimeID == 1 then
        Base.ClickRectEx(200,190,35,20)
    elseif TimeID == 2 then
        Base.ClickRectEx(300,190,35,20)
    elseif TimeID == 3 then
        Base.ClickRectEx(400,190,35,20)
    elseif TimeID == 4 then
        Base.ClickRectEx(500,190,35,20)
    elseif TimeID == 5 then
        Base.ClickRectEx(200,190,35,20)
    end
end

function ȡɫ.Point_ID(PointID)  
    if PointID == 1 then
        Base.ClickRectEx(250,290,100,6)
    elseif PointID == 2 then
        Base.ClickRectEx(250,320,100,6)
    elseif PointID == 3 then
        Base.ClickRectEx(250,350,100,6)
    elseif PointID == 4 then
        Base.ClickRectEx(250,380,100,6)
    end
end


return ȡɫ