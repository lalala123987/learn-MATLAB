[X0,Y0,Z0] = ellipsoid(0,0,0,1,1,1);
t1 = 0;
while true
    
    t0 = 0:0.01:2*pi;
    x0 = 5*cos(t0);
    y0 = 5*sin(t0);
    z0 = 0*t0;
    hold off;
    m0 = mesh(X0,Y0,Z0);%绘制地球
    direction0 = [0 1 0];
    rotate(m0,direction0,15);%设置地轴倾角
    xlim([-6 6]);
    ylim([-6 6]);
    zlim([-6 6]);
    hold on;
    
    plot3(x0,y0,z0);%绘制月球轨道
    xlim([-6 6]);
    ylim([-6 6]);
    zlim([-6 6]);
    
    t2 = -10:0.1:10;
    x2 = t2*sin(pi/12);
    y2 = 0*t2;
    z2 = t2*cos(pi/12);
    plot3(x2,y2,z2);%绘制地轴
    
    r1 = 0.5;
    t1 = t1+0.02;
    x1 = 5*cos(t1);
    y1 = 5*sin(t1);
    z1 = 0;
    [X1,Y1,Z1] = ellipsoid(x1,y1,z1,r1,r1,r1);
    mesh(X1,Y1,Z1);%绘制月球
    xlim([-6 6]);
    ylim([-6 6]);
    zlim([-6 6]);
    pause(0.001);
end