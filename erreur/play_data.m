close all;
clear all;
clc;


load ('7.mat');

X = motion.jointX.smoothed;
Y = motion.jointY.smoothed;
Z = motion.jointZ.smoothed;

Q = motion.trajectory.q;

h = plot3(X(:,1) , Y(:,1) , Z(:,1),'.');
hold on;
%hq = plot3(Q(1,1) , Q(2,1) , Q(3,1),'r.', 'MarkerSize', 20);

grid on;
xlabel ('X');
ylabel ('Y');

jx=motion.jointX.smoothed;
jy=motion.jointY.smoothed;
jz=motion.jointZ.smoothed;

seg1=-[jx(7,1)-jx(6,1);jy(7,1)-jy(6,1);jz(7,1)-jz(6,1)];
d_seg2=sqrt((jx(1,1)-jx(6,1))^2+(jy(1,1)-jy(6,1))^2+(jz(1,1)-jz(6,1))^2);
d_seg1=sqrt(transpose(seg1)*seg1);
seg2=[0 1 0]*d_seg2;
seg2=rot_x(-Q(18,1))*rot_y(-Q(19,1))*rot_z(-Q(20,1))*transpose(seg2);

Xi=[jx(7,1);jx(7,1)+seg1(1);jx(7,1)+seg1(1)+seg2(1)];
Yi=[jy(7,1);jy(7,1)+seg1(2);jy(7,1)+seg1(2)+seg2(2)];
Zi=[jz(7,1);jz(7,1)+seg1(3);jz(7,1)+seg1(3)+seg2(3)];

hqq=plot3(Xi,Yi,Zi);
axis square equal;
axis ([-500, 500, 0, 1500  -500, 500 , ] );

for i=8000:size(X,2)
    set(h, 'XData' , X(:,i));
    set(h, 'YData' , Y(:,i));
    set(h, 'ZData' , Z(:,i));
    
%     set (hq, 'Xdata', -Q(3,i));
%     set (hq, 'Ydata', -Q(1,i));
%     set (hq, 'Zdata', Q(2,i));
    seg1=-[jx(7,i)-jx(6,i);jy(7,i)-jy(6,i);jz(7,i)-jz(6,i)];
    seg2=seg1*d_seg2/d_seg1;
    seg2=rot_x(Q(18,i))*rot_y(Q(19,i))*rot_z(Q(20,i))*seg2;

    Xi=[jx(7,i);jx(7,i)+seg1(1);jx(7,i)+seg1(1)+seg2(1)];
    Yi=[jy(7,i);jy(7,i)+seg1(2);jy(7,i)+seg1(2)+seg2(2)];
    Zi=[jz(7,i);jz(7,i)+seg1(3);jz(7,i)+seg1(3)+seg2(3)];
    
    set(hqq, 'XData' , Xi);
    set(hqq, 'YData' , Yi);
    set(hqq, 'ZData' , Zi);
    drawnow;
    
    title (sprintf('%d',i));
    Fxyz2(i)=transpose(([Xi(3);Yi(3);Zi(3)]-[jx(1,i);jy(1,i);jz(1,i)]))*([Xi(3);Yi(3);Zi(3)]-[jx(1,i);jy(1,i);jz(1,i)]);
end;
