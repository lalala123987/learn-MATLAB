clear;clc;
%初始化卡牌，获得1-26随机排序数组
r = randi([1 10],1,26);
[~,cards] = sort(r);

playernum = 4; %人数2.3.4
cardnum = 12/playernum; %每人初始发牌数
cardnow = 12;%被抽走的牌数
playerpoint = zeros(playernum); %玩家的分数

%初始发牌
for i = 1:playernum
    playercard(i,1:cardnum) = cards(1,(i-1)*cardnum+1:i*cardnum); %每个玩家获得初始牌playercard
    cardnum_now(i) = cardnum;%每个玩家目前手牌数量cardnum_now
end
[playercard,~] = sort(playercard);%对初始牌排序
playerstate = 0*playercard;%初始化玩家卡牌状态矩阵，0为未开，1为已被开
while 1
    playerout = 0;%已淘汰玩家数
    for j = 1:playernum
        if playerstate(j,1:cardnum_now(j)) ==ones(cardnum_now(j))
            playerout=playerout+1;
            continue
        else
            cardnow = cardnow + 1;
            if cardnow >26
                continue
            else
                cardnum_now(j) = cardnum_now(j)+1;
                playercard(j,cardnum_now(j)) = cards(1,cardnow);%玩家抽牌
                playerstate(j,cardnum_now(j)) = 0; %将卡牌状态设置为未被开
            end
            gressstate = 1;  %是否猜牌状态
            while gressstate ==1
                [gressstate,playerstate,playerpoint] = gress (j,cardnum_now(j),playerstate,playerpoint,playercard,cardnum_now); 
                %猜牌函数，输入猜牌玩家号，玩家目前手牌数，手牌状态矩阵，玩家分数矩阵，玩家手牌矩阵,所有玩家当前手牌数量矩阵
                %输出猜牌输赢状态，手牌状态矩阵，玩家分数矩阵
                [playercard(j,:),sortnum] = sort(playercard(j,:));
                for k = 1:cardnum_now(j)
                    playerstate1(1,k) = playerstate(j,sortnum(k));
                end
                playerstate(j,:) = playerstate1;
                if gressstate ==1%如果玩家猜牌正确，则询问是否再次猜牌
                    gressstate = input("是否继续猜数，如果继续，则输入1，如果不猜则输入0");
                end
            end
        end
    end
    if playerout==playernum-1%只剩一个玩家，游戏结束
        disp("游戏结束！");
        for k=1:playernum
            if playerstate(k,:) ==ones(cardnum_now(k))
                continue
            else
                winner = k;
            end
        end
        disp("胜利的玩家是："+winner);
        disp("玩家的分数矩阵是：");
        disp(playerpoint);
    else
        continue;
    end
end