function threebody(Mass1x3,Velocity3x3,Position3x3,Frequency)
%%——————————————————————————————————————————————————————————————————————————————
%% 初始状态
if nargin < 3
    %速度
    v1 = [0,0,0];
    v2 = [0,0,0];
    v3 = [4000,4000,-4000];
    %质量
    m1 = 15*10^24;         %蓝
    m2 = 10*10^24;         %红
    m3 = 5*10^24;          %绿
    %初始点
    m1_position = [0,10000000,10000000];
    m2_position = [10000000,0,0];
    m3_position = [-5000000,0,5000000];
    tstep = 0.005;
elseif nargin < 4
    tstep = 0.01;
    v1 = Velocity3x3(1:3,1);
    v2 = Velocity3x3(1:3,2);
    v3 = Velocity3x3(1:3,3);
    m1 = Mass1x3(1);
    m2 = Mass1x3(2);
    m3 = Mass1x3(3);
    m1_position = Position3x3(1:3,1);
    m2_position = Position3x3(1:3,2);
    m3_position = Position3x3(1:3,3);
else
    v1 = Velocity3x3(1:3,1);
    v2 = Velocity3x3(1:3,2);
    v3 = Velocity3x3(1:3,3);
    m1 = Mass1x3(1);
    m2 = Mass1x3(2);
    m3 = Mass1x3(3);
    m1_position = Position3x3(1:3,1);
    m2_position = Position3x3(1:3,2);
    m3_position = Position3x3(1:3,3);
    tstep = Frequency;
end
%星球半径
R0 = 300;%30000
m0 = 2*10^24;
R1 = R0*((m1/m0)^0.33);
R2 = R0*((m2/m0)^0.33);
R3 = R0*((m3/m0)^0.33);
%相撞距离
Rc12 = R1+R2;
Rc23 = R2+R3;
Rc13 = R1+R3;
%引力常数   
G = 6.67*10^-11;%6.67*10^-11
%%——————————————————————————————————————————————————————————————————————————————
%% 运动定律
%
j = 0;%绘图循环,此处设置循环开始
%
colordef white
figure
grid on
hold on
axis equal
p1 = plot3(m1_position(1),m1_position(2),m1_position(3),'b:.','markersize',30);
p2 = plot3(m2_position(1),m2_position(2),m2_position(3),'r:.','markersize',30);
p3 = plot3(m3_position(1),m3_position(2),m3_position(3),'g:.','markersize',30);
%xlim([-1.5*10^7 1.5*10^7]);
%ylim([-1.5*10^7 1.5*10^7]);
%zlim([-1.5*10^7 1.5*10^7]);
h1 = animatedline('color','b','MaximumNumPoints',300);
h2 = animatedline('color','r','MaximumNumPoints',300);
h3 = animatedline('color','g','MaximumNumPoints',300);
xlabel('X')
ylabel('Y')
zlabel('Z')
for i = 1:8192000000000000000
    %星球间距离
    r12 = normest(m2_position-m1_position);
    r23 = normest(m3_position-m2_position);
    r13 = normest(m3_position-m1_position);
    %引力大小
    F12_len = G*m1*m2/(r12^2);
    F23_len = G*m2*m3/(r23^2);
    F13_len = G*m1*m3/(r13^2);
    %引力方向单位向量
    F12_dir = (m2_position-m1_position)/normest(m2_position-m1_position);%1指向2
    F23_dir = (m3_position-m2_position)/normest(m2_position-m3_position);%2指向3
    F13_dir = (m3_position-m1_position)/normest(m1_position-m3_position);%1指向3
    %加速度向量
    a1 = ((F12_len)*F12_dir+(F13_len)*F13_dir)/m1;
    a2 = ((-F12_len)*F12_dir+(F23_len)*F23_dir)/m2;
    a3 = ((-F23_len)*F23_dir+(-F13_len)*F13_dir)/m3;
    %改变速度
    v1 = a1*tstep+v1;
    v2 = a2*tstep+v2;
    v3 = a3*tstep+v3;
    %改变位置
    m1_position = tstep*v1+m1_position;
    m2_position = tstep*v2+m2_position;    
    m3_position = tstep*v3+m3_position;
    %绘图循环
    j = j+1;
    while j == 1024
        j = 0;
        set(p1,'Xdata',m1_position(1),'Ydata',m1_position(2),'Zdata',m1_position(3));
        set(p2,'Xdata',m2_position(1),'Ydata',m2_position(2),'Zdata',m2_position(3));
        set(p3,'Xdata',m3_position(1),'Ydata',m3_position(2),'Zdata',m3_position(3));
        addpoints(h1,m1_position(1),m1_position(2),m1_position(3));
        addpoints(h2,m2_position(1),m2_position(2),m2_position(3));
        addpoints(h3,m3_position(1),m3_position(2),m3_position(3));
        drawnow
        view(3)
    end
    %检查相撞
    if r12 < Rc12 || r23 < Rc23 || r13 < Rc13
        break
    end
end
string = {'两星相撞'};
title(string);
