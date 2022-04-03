function [gressstate,playerstate,playerpoint] = gress (gressernum,cardnum_now,playerstate,playerpoint,playercard,cardnum_nowall)
%猜牌函数，输入猜牌玩家号，玩家目前手牌数，手牌状态矩阵，玩家分数矩阵，玩家手牌矩阵,所有玩家当前手牌数量矩阵
%输出猜牌输赢状态，手牌状态矩阵，玩家分数矩阵
disp("当前玩家："+gressernum);%输出当前玩家号
disp("目前所有玩家可展示卡牌：");
disp(playerstate.*playercard);%输出所有玩家当前可展示卡牌
disp("所有玩家当前手牌数");
disp(cardnum_nowall);
i = 1;
while i ==1
    gressplayernum = fix(input("请输入你想猜牌的玩家号码,1-4:")); %被猜牌玩家号
    if gressplayernum==gressernum
        disp("不能自己猜自己的牌");
    elseif gressplayernum==1||gressplayernum==2||gressplayernum==3||gressplayernum==4
        i = 0;
    else
        disp("请输入正确的玩家号！");
    end
end
while i ==0
    gresscardnum = fix(input("请输入你想猜的牌的号码，从左向右")); %被猜牌号0
    if gressplayernum<gressernum
        maxcard = cardnum_nowall(gressplayernum)+1;
    elseif gressplayernum>gressernum
        maxcard = cardnum_nowall(gressplayernum)+2;
    end
    if gresscardnum>0&&gresscardnum<maxcard
        if playerstate(gressplayernum,gresscardnum) ==1
            disp("此牌已被开，请重新选择");
        else
            i=1;
        end
    else
        disp("请输入正确的牌的号码");
    end
end
while i==1
    gresscardvalue = fix(input("请输入你想猜的牌的值，黑1=1，白1=2，黑鬼=25，白鬼=26")); %猜牌数值
    if gresscardvalue==0
        dist("请重新猜数，不能猜0");
    else
        i =0;
    end
end
if playercard(gressplayernum,gresscardnum)==gresscardvalue
    disp("猜测正确");
    playerstate(gressplayernum,gresscardnum) = 1;
    gressstate = 1;
    if sum(playerstate(gressplayernum,:)) == size(playerstate(gressplayernum,:),2)
        playerpoint(gressernum) = playerpoint(gressernum) +50;
    elseif gresscardvalue == 11||gresscardvalue == 12||gresscardvalue == 25||gresscardvalue == 26
        playerpoint(gressernum) = playerpoint(gressernum) +20;
    else
        playerpoint(gressernum) = playerpoint(gressernum) +10;
    end
else
    disp("猜测错误");
    gressstate = 0;
    playerstate(gressernum,cardnum_now) = 1;
end
    