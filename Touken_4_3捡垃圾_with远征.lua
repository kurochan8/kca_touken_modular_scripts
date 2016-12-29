--����BY uint(?) ����BY ��������
--��ŵ����һ���ļ�����ʹ��
--����ϸ��������ڻͼ���һ��1-1

--/**********************************����������**************************************/
--ѭ����������(�����ͼ���˳���ͼΪ1��)
max_count = 300;

--����ʧ�ܺ�ʹ�õ�����
--����1-6����Ϊ ���� ��� ���� ���� ���� ���� �����1-6��ֵ ��ѡ��2
formation = 2;

--���ò����䳤��ʱ,������ҹ��һ�ʱ����
longDelayEnabled = false;

--�����䳤��ʱ����,��λΪ��
longDelayDuration = 28;


Զ���趨 = {
    -- Զ�������ʱ��ѡ�񣬴����ҷֱ���2�ӣ�3�ӣ�4�ӡ�����ĸ������nil�����ǲ�Զ��
    Զ������ʱ�� = {nil, {1,1}, {2, 2}},
	--Զ������ʱ�� = {{1,1},nil,nil},

}

--/*********************************************************************************/

require("API��չ") 
Զ������ = require("Զ��")
local ͨ�� = require("ͨ��")
local ���� = ͨ��.����


expedition = Զ������(Զ���趨)

--ս����ɺ����
PROC_TYPE_ONSLAUGHT = 1;

--ս����ɺ���
PROC_TYPE_RETREAT = 2;

--ս����ɺ����κβ���
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
	
    array = {[0]=403,434,14741750}; count[0] = array; --�ж�D���Ƿ�����

    return IsColorAll(count)
end

function RouteChoice_IsColorAll()
    array = {};count = {};
	
    array = {[0]=883,249,2377040}; count[0] = array; --�ж�D���Ƿ�����

    return IsColorAll(count)
end

--���˼��
function CheckSeriouslyInjured()
	i = 0;
	result = 0;
	for i = 1 , 6 do
    	if Base.IsColor(195,190+67*(i-1),131823) then
			--��һ�ѵ�����,�ͰѶ�Ӧ�Ķ�����λ��1.
			--�൱��result = result | 1 << (i - 1)
            --|(MSB) 8  7  6  5  4  3  2  1 (LSB)|<-������λ
            --|      -  -  6  5  4  3  2  1      |<-�����ڶ�����λ��
            --����ڶ�������İѵ�����,�򷵻�0b00001010.
            --����������չ�õ�,����û��ʲô����.
			result = result + 2 ^ (i - 1)
		end
	end
	return result;
end 

function IsFormationControl()   --�������ѡ�����
    count = {};
	
	table.insert(count,0,{[0]=446,25,16776959}); 
	table.insert(count,0,{[0]=529,29,16711422});
	table.insert(count,0,{[0]=52,546,659210});
	table.insert(count,0,{[0]=906,464,3618345}); 

    return IsColorAll(count)
end

--�Ƿ��ڽ������˻���
function IsProcessControl()
	count = {};
	
	table.insert(count,0,{[0]=587,294,16777215}); 
	table.insert(count,0,{[0]=651,309,16777215}); 
	table.insert(count,0,{[0]=806,294,16777215}); 
	table.insert(count,0,{[0]=867,301,16777215}); 
	
    return IsColorAll(count)
end

function IsGameFrameInvalid() --�жϽ����Ƿ���ȷ
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

function IsHome() --�ж��Ƿ��ڱ���
	count = {}
	
	table.insert(count,0,{[0]=71,47,3700737});
	table.insert(count,0,{[0]=52,359,3768321}); 
	table.insert(count,0,{[0]=50,552,2116608});
	table.insert(count,0,{[0]=875,71,2050817});
	table.insert(count,0,{[0]=940,68,2117633});

	return IsColorAll(count)
end


--/**********************/
--/*�ж϶Ի����Ƿ�������*/
--/* ****************** */
--/*  ����ֵ:�Ի����Ƿ� */
--/*  ����              */
--/**********************/
function IsMsgbox()
    return (Base.ImageHashContrast(Base.ImageHash(252,153,100,50),"007F7F7F7E7F7F7F") < 10);
end

--/**********************/
--/*     ����Ի���     */
--/* ****************** */
--/*   option:�ǻ��    */
--/* ����ť�Ի�������� */
--/*   ����ֵ:�Ƿ�ɹ�  */
--/**********************/
function ProcessMsgbox(option)
    --����������
    time = 0;

    --��û�жԻ�����������
    if not IsMsgbox() then
        return false;
    end

    --ѭ�����ֱ���Ի�����ʧ����ʱ60s��ÿ500ms��������һ��
    while IsMsgbox() and time < 120 do
        --�Ƿ���"��"��ť
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
	--���������������
	positiveFormation = 0;
	
	for x = 0, 2 do
		for y = 0, 1 do
			if Base.IsColorEx(117 + (x * 262), 146 + (y * 186), 66269, 8) then
				--��x/yλ�û������λ��,ʮλΪx,��λΪy,��Χx[1,3],y[1,2].
				Base.Print("x=" .. x .. "  y=" .. y);
				positiveFormation = (x + 1) * 10 + (y + 1);
				Base.Print("fm=" .. positiveFormation);
				break;
			end
		end
	end
	
	--����ʧ��
	if positiveFormation == 0 then
		--ֱ�Ӱ��մ���Ĳ���ѡ��
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
		Base.Print("����ʧ��");
	else
		--����λ����ԭ��x��y,�ٳ��Ի������겢����һ��ƫ��,ʹʵ������λ�ڰ�ť����.
		xPos = 117 + ((positiveFormation / 10 % 10) - 1) * 262 + 100;
		yPos = 146 + ((positiveFormation % 10) - 1) * 186 + 20;
		Base.ClickRect(xPos, yPos, 30);
	end
end

--/************************/
--/*       ����ս��       */
--/*�������Դ��(һֱ����)*/
--/* *******************  */
--/*    processType:ս��  */
--/*       ��Ϻ����     */
--/*   1=������ 2=������  */
--/*   ����=�����κβ���  */
--/*  ����-1Ϊ���ص�����  */
--/*  ����>128Ϊ�е�����  */
--/************************/
function ProcessBattle(processType)
	Win.Print("�ȴ�ѡ������...");
	
    while not IsFormationControl() do
		Base.ClickRect(471,547,50);
        Base.Sleep(1000, true);
 
		if IsHome() then
			return -1;
		end
    end
	
	Base.Sleep(200, true);
	
	FormationChoice();
	Base.Print("����ѡ�����,ս����ʼ...");
	
	while not IsProcessControl() do
		Base.ClickRect(268,303,50)
        Base.Sleep(1000, true)
    end
	
	Base.Sleep(800);
	
	--�������
	injury = CheckSeriouslyInjured();
	if injury ~= 0 then
		--�ȳ���
		Base.ClickRect(827,271,25);
		--�������˵�����,��8λ��1
		return injury + 128;
	end
	
	while IsProcessControl() do 
		if processType == 1 then
			--����
			Base.ClickRect(613,275,25);
		elseif processType == 2 then
			--����
			Base.ClickRect(827,271,25);
		else
			--����
			break;
		end
	end
	
	return 0;
end

--/***main()***/
Base.SetConfig("Sleep+?", 1500);
if IsGameFrameInvalid() then
	error("����:Flashδ��ȡ!");
end


-- ��ħ��(��)��ûʲô����Ļ����鲻Ҫ��
ȫ���趨 = {
    -- ����Ҫ��鵱ǰ�����Ƿ���ĳ��״̬ʱ���೤ʱ����һ�Ρ�����λ�����룩
    ״̬����� = 200,
    -- ����Ҫ��鵱ǰ�����Ƿ���ĳ��״̬ʱ��������á�0Ϊ����������Ц������λ�����룩
    ״̬��鳬ʱ = 2000,
    -- Ϊ���ýű�����Ϊ����Ȼ����ĳЩ�����󸽼�һЩ������ӳ١�����λ�����룩
    ������ʱ���� = 600,
}

for n = 1, max_count do --ѭ������
    ����.�ر���()
    expedition.ִ��(expedition)
	Win.Print("ѭ������:��" .. n .. "��,��" .. max_count .. "��")
	
	if not Touken.����(4,3,HaltIfKebiishiFound) then 
		error("����:��ͼ�����ü��Υʹ!");
	end
	
	Base.Sleep(2000);
	
	--�жϵȼ������Ի������
	if IsMsgbox() then
		ProcessMsgbox(false);
		error("����:����ƽ���ȼ���������!");
	end
	
	Base.Click(626,501);
	Base.Sleep(500, true);
	
	for i =1, 3 do
		Base.Print("ǰ3��ս��:���ڽ��е�" .. i .. "��");
		result = ProcessBattle(PROC_TYPE_ONSLAUGHT);
           if result > 0 then
               error("����:�е�������!");
           end
	end
			
	Win.Print('��ս�������ȴ�ȷ��·��')
	while not RouteChoice_IsColorAll() do
       	Base.Sleep(1000)
   	end
	
	if Route_IsColorAll() then		
		max_battle_count = 3;
		Win.Print('����·��ȷ��Ϊ�·�,��������3��');
		else
		max_battle_count = 1;
		Win.Print('����·��ȷ��Ϊ�Ϸ�,��������1��');
	end
	
	for i = 1, max_battle_count do
		Base.Print("����ս��:��" .. i .. "��,��" .. max_battle_count .. "��");
		--���һ��ս����ɺ���
		if i ~= max_battle_count then
			Base.Print("�˴���ɺ����");
			result = ProcessBattle(PROC_TYPE_ONSLAUGHT);
		else
			Base.Print("�˴���ɺ���");
			result = ProcessBattle(PROC_TYPE_RETREAT);
		end
		--�˻ص�����,ֱ�ӽ�����һ��
		if result == -1 then
			Base.Print("�˻ر���,�˴ε�ͼս������");
			break;
        elseif result > 0 then
               error("����:�е�������!");
		end
	end
	
	if longDelayEnabled then
		Base.Print("�����䳤��ʱ...");
		time = 0;
		while time < longDelayDuration do
			Base.Sleep(1000);
			time = time + 1;
			if time % 60 == 0 then
				Base.Print("�ѵȴ�" .. time / 60 .. "min");
			end
		end
		Base.Print("ƫ���ӳ�...(1-3min)");
		Base.SetConfig("Sleep+?", 180000);
		Base.Sleep(60000, true);
		Base.SetConfig("Sleep+?", 1500);
	else
		Base.Sleep(2000, true);
	end
end
