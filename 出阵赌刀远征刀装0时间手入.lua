--���Ǹ����ӻ� BY sakura_candy��Ⱥ��@��������
--�ĵ�library��uint
--���룺������������棩& <����>��</����>
--Զ����MaSaXX
--���ܲ𵶣����£��������ӣ���
--�տΣ��ĵ���ܣ���sieben �����տ�ʲô�ľ����������Ѿ��ص��ˣ��ǵ�ÿ��ˢ��һ����Ϸˢ��½������
--����װ������

--�������Ǻ�����ˣ�ֻ��contributeһ��

require("��_ģ�黯�ű�")

---------------------------------------------------------------------
--�������������� һ��ֻ���޸������ֵ����

--Զ������
--ҪԶ���Ļ���Ҫ��TouKen_Զ��_0.6.0_mod.lua��TouKen_Զ��_0.6.0.lua �޸����úͿ��أ�һ��Ҫһ��
Զ������ = true

--�ĵ����أ�ͬ�ϣ���Touken_Smith.lua����������Ҫ���䷽���ĵ�λ��������
smith = false
--����ʱ�����ޣ�������㣨д����ʱ��ͺã��¶ĵ���4h���ǲ𵶽ű���������С�Ĳ��ˣ�������14400��4Сʱ��
stop_timer = 144000

--���봲λ�����1�����4�������ֻ���4��λû�3�š��� ��Ȼ�����4��λΪɶ���3���أ������������4Ӧ��Ҳ���԰ɣ�
bed_count = 4

--�����true�����˺�ֹͣ�ű���һ��һ��Ҫ�ͺ���ġ������������񡱺͡��������䵶װ����һ���á�
--ע�⣡����������ǧ��Ҫ��ʱ��AFK�������鵶���и��ʴ��ڵģ��������������������������������� ---BY ��������
--�����false�����˺�ֹͣ������ص�����
���˺�ֱ����������� = true

--��ͼ
map_id = {2,4}

max_count = 10000
--��������ٴε�ͼ

max_battle_count = 50
--��������ٴ�ս����

formation = 2
--����ʧ�ܺ�ʹ�õ�����
--����1-6����Ϊ ���� ��� ���� ���� ���� ���� �����1-6��ֵ ��ѡ��2

team_id = 1
--�����Ķ���(1-4)

--��ϸ�趨����ȥ ��_ģ�黯�ű�.lua ��ο�
����Ͳ���װ = ����������({
    ������������({
        ���ò��� = {true, true, false, false},
        �������˵ȼ� = "΢��",
        ʹ�ü������˵ȼ� = nil,
        �������Ƹ����˵ȼ� = false,
    }),
    �������䵶װ����({
        ���Ӻ� = 1,
		--�������Ѿ�Ԥ��õģ�����ȥ ���䵶װ.lua ��鿴������������Լ���Ҫ�Ĳ���
        [1] = {
            ���� = "����Ͷʯ�Ჽ",
            ���������⵶װ = true,
        },
        [2] = {
            ���� = "����Ͷʯ�Ჽ",
            ���������⵶װ = true,
        },
        [3] = {
            ���� = "����Ͷʯ�Ჽ",
            ���������⵶װ = true,
        },
        [4] = {
            ���� = "����Ͷʯ�Ჽ",
            ���������⵶װ = true,
        },
        [5] = {
            ���� = "����Ͷʯ�Ჽ",
            ���������⵶װ = true,
        },
        [6] = {
            ���� = "����Ͷʯ�Ჽ",
            ���������⵶װ = true,
        },
    }),
}, 1)


ignore_lv_msg = false
--�Ƿ����ӵȼ���ʾ

������ǲ������ͼ = false
--�ð� ��֪����ô���� ֱ�������ı�����
--���Ϊtrue ���ڳ���ʱ��ͼ���м�Ǳ�Ǿͻ᷵�س���ʧ��

ս�����������ֹͣ�ű� = false
--����������Ǵ򲻴�false=��ֹͣ true=ֹͣ

ս��������ֹͣ�ű� = false
--false=��ֹͣ true=ֹͣ

ս��������ֹͣ�ű� = false
--false=��ֹͣ true=ֹͣ

Base.SetConfig("Sleep+?", 331)
---------------------------------------------------------------------

--����Ķ�����Ҫ�Ҹ��ˣ� �͸���������þ���
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

function IsDmmunlocker() --�жϽ����Ƿ���ȷ
    array = {};count = {}
    array = {[0]=17,19,16777215};count[0] = array
    array = {[0]=52,15,16777215};count[1] = array
    array = {[0]=105,16,16777215};count[2] = array
    array = {[0]=165,16,16777215};count[3] = array
    return IsColorAll(count)
end

if ���˺�ֱ����������� then
    Win.Pop("ע�⣡����������ǧ��Ҫ��ʱ��AFK�������鵶���и��ʴ��ڵģ�����������װ�ϣ�")
end

local startT = os.clock()
Win.Print(string.format("Start time %.2f\n", startT))

����Ͳ���װ:��ʼ����()

if IsDmmunlocker() == false then
    mode = 0
    if ս�����������ֹͣ�ű� == true then
        mode = mode + 4
    end
    if ս��������ֹͣ�ű� == true then
        mode = mode + 1
    end
    if ս��������ֹͣ�ű� == true then
        mode = mode + 2
    end

    for n = 1, max_count do --ѭ������
        Win.Print(string.format("Current time %.2f\n", os.clock()))
        if  (os.clock() - startT) > stop_timer then
            Win.Print("ʱ�䵽��ֹͣѭ��")
            break
        end

        a = "��ʼ��:%d��"
        Win.Print(a:format(n))

        if Զ������ == true then
            Win.Print("Զ��")
            package.loaded["TouKen_Expedition_0_6_0_mod"] = nil
            require("TouKen_Expedition_0_6_0_mod")

        end
        if smith == true then

            Win.Print("�ĵ�")
            package.loaded["Touken_Smith"] = nil
            require("Touken_Smith")
        end

        EnterHome()

        if Touken.����(map_id[1],map_id[2],������ǲ������ͼ) == false then
            Win.Print('�޷������˳�')
            break --�޷�����
        end

        --ս��
        ret = Tou.Battle(max_battle_count, formation, mode, team_id, ignore_lv_msg)
        if ret > 0 then
            if ���˺�ֱ����������� then --�������룬ֻ�������˵�
                Win.Print('���ˣ�������Ѷ�Ա������') --����������
                status = ����Ͳ���װ:��ʼ����()
                if status < 0 then
                    Win.Print('���벹��װ��������жϽű�')  -- ����û�п�������λ
                    break
                end
            else
                Win.Print('�����жϽű�') --����������
                break
            end
        end

        if ret == -1 then
            Win.Print('����жϽű�') --���ּ��

            Base.ReLoad()
            while Base.IsColor(468,453,7747046) == false
            do
             Base.Click(468,453)
             Base.Sleep(2000,true)
            end
            Base.Click(468,453)
        end

        if ret == -2 then
            Win.Print('�����ȼ� �жϽű�') --���ּ��
            break
        end

        if ret == 0 then
            Win.Print('��Ȼ��0ʱ�������Ǿʹ�Ҷ�ȥ���һ���ٿ�ʼ��һ�ֵĸ�') -- ����û�п�������λ
            status = ����Ͳ���װ:��ʼ����()
			if status < 0 then
				Win.Print('���벹��װ��������жϽű�')  -- ����û�п�������λ
				break
			end
        end

    end
else
    Win.Print('��⵽��Ϸ�ڴ��ڿհף������޷���Ӧ���ű��޷����У�') --����������
end

Win.Pop('�ű�ִ����ϣ�')
