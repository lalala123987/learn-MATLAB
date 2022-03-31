clear;clc;fmat=moviein(50);
a = 7; b = 3; c = 5;  %椭球的半轴长
for i=-8:0.5:8
    %！！！注意：由于此方法是正向求出方程，在使用三角参数方程将隐函数化为显函数时需开根号，
    %！！！导致了其中一项（交叉项）不能为负（如只用隐函数表示则无此问题），又由于MATLAB
    %！！！无法绘制三维隐函数图像，故无法实现对于出现交叉项的情况的绘制，即：平面标准方程中，
    %！！！A与B的值需至少有一个为0，否则会出现交叉项使根号内为负导致错误！
    A = 0; B = i; C = 2; D = 1;  %平面标准方程Ax+By+Cz+D=0
    alpha01 = (a*A)^2+(b*B)^2+(c*C)^2;  %定义的一个参量
    d0 = abs(D)/sqrt(alpha01);  %椭球心到仿射后平面距离
    %画椭球
    [X,Y,Z] =  ellipsoid(0,0,0,a,b,c,40);
    surf(X,Y,Z);
    alpha(0.2);
    hold on
    %画截面
    n = [A B C];
    [x3,y3] = meshgrid(-max([a b])-1:0.1:max([a b])+1);
    D3 = zeros(size(x3))+D;
    z3 = -(A*x3+B*y3+D3)/C;
    mesh(x3,y3,z3);
    alpha(0.1);
    hold on
    %仿射后截痕圆的圆心坐标
    x0 = a*A*d0/sqrt(alpha01);
    y0 = b*B*d0/sqrt(alpha01);
    z0 = c*C*d0/sqrt(alpha01);
    R = 1-D^2/alpha01; %仿射后球与平面截痕圆的半径
    for t=0:0.1:2*pi+0.1
        y1 = R*sin(t)/sqrt(1+(b*B)^2/(c*C)^2-(a*b*c*A*B*C)^2/((a*A)^2+(c*C)^2));
        x1 = (R*cos(t)-y1*a*b*c*A*B*C/sqrt((a*A)^2+(c*C)^2))/sqrt(1+(a*A)^2/(c*C)^2);
        x(round(10*t+1)) = (x1-x0)*a;
        y(round(10*t+1)) = (y1-y0)*b;
        z(round(10*t+1)) = -(A*x(round(10*t+1))+B*y(round(10*t+1))+D)/C;
    end
    plot3(x,y,z,'r','LineWidth',2);
    view(3);
    axis([-8 8 -6 6 -5 5],'manual');
    fmat(:,2*i+17)=getframe;
    hold off
end
movie(fmat,100);