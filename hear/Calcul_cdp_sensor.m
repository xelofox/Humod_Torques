% vectorL1 =[700;-41;-270];
% vectorL2 =[700;-41;-32];
% vectorL3 =[-700;-41;-32];
% vectorL4 =[-700;-41;-270];
% vectorR1 =[700;-41;32];
% vectorR2 =[700;-41;270];
% vectorR3 =[-700;-41;270];
% vectorR4 =[-700;-41;32];

vectorL1 =[700;0;-270];
vectorL2 =[700;-0;-32];
vectorL3 =[-700;-0;-32];
vectorL4 =[-700;-0;-270];
vectorR1 =[700;-0;32];
vectorR2 =[700;-0;270];
vectorR3 =[-700;-0;270];
vectorR4 =[-700;-0;32];

file='6.mat';
load(file);

copX_R=zeros(1,force.frames);
copY_R=zeros(1,force.frames);
copZ_R=zeros(1,force.frames);
copX_L=zeros(1,force.frames);
copY_L=zeros(1,force.frames);
copZ_L=zeros(1,force.frames);

grfX_L=zeros(1,force.frames);
grfX_R=zeros(1,force.frames);
grfZ_L=zeros(1,force.frames);
grfZ_R=zeros(1,force.frames);

for k=1:force.frames
    k
    cdpR=transpose((vectorR1*force.forceSensorY_R1(k) + vectorR2*force.forceSensorY_R2(k) + vectorR3*force.forceSensorY_R3(k) + vectorR4*force.forceSensorY_R4(k))/(force.forceSensorY_R1(k)+force.forceSensorY_R2(k)+force.forceSensorY_R3(k)+force.forceSensorY_R4(k)));
    cdpL=transpose((vectorL1*force.forceSensorY_L1(k) + vectorL2*force.forceSensorY_L2(k) + vectorL3*force.forceSensorY_L3(k) + vectorL4*force.forceSensorY_L4(k))/(force.forceSensorY_L1(k)+force.forceSensorY_L2(k)+force.forceSensorY_L3(k)+force.forceSensorY_L4(k)));
    copX_R(k)=cdpR(1);
    copY_R(k)=cdpR(2);
    copZ_R(k)=cdpR(3);
    copX_L(k)=cdpL(1);
    copY_L(k)=cdpL(2);
    copZ_L(k)=cdpL(3);
end