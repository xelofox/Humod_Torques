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

vectorS1 =[   800;  -278;  -415]
vectorS2 =[   800;  -278;  415]
vectorS3 =[   -800;  -278;  415]
vectorS4 =[   -800;  -278;  -415]

file='6.mat';
load(file);

force.copX_R=zeros(1,force.frames);
force.copY_R=zeros(1,force.frames);
force.copZ_R=zeros(1,force.frames);
force.copX_L=zeros(1,force.frames);
force.copY_L=zeros(1,force.frames);
force.copZ_L=zeros(1,force.frames);

force.grfX_L=zeros(1,force.frames);
force.grfX_R=zeros(1,force.frames);
force.grfZ_L=zeros(1,force.frames);
force.grfZ_R=zeros(1,force.frames);

for k=1:force.frames
    k
    cdpR=transpose((vectorR1*force.forceSensorY_R1(k) + vectorR2*force.forceSensorY_R2(k) + vectorR3*force.forceSensorY_R3(k) + vectorR4*force.forceSensorY_R4(k))/(force.forceSensorY_R1(k)+force.forceSensorY_R2(k)+force.forceSensorY_R3(k)+force.forceSensorY_R4(k)));
    cdpL=transpose((vectorL1*force.forceSensorY_L1(k) + vectorL2*force.forceSensorY_L2(k) + vectorL3*force.forceSensorY_L3(k) + vectorL4*force.forceSensorY_L4(k))/(force.forceSensorY_L1(k)+force.forceSensorY_L2(k)+force.forceSensorY_L3(k)+force.forceSensorY_L4(k)));
    force.copX_R(k)=cdpR(1);
    force.copY_R(k)=cdpR(2);
    force.copZ_R(k)=cdpR(3);
    force.copX_L(k)=cdpL(1);
    force.copY_L(k)=cdpL(2);
    force.copZ_L(k)=cdpL(3);
    
%     cFX=(force.forceSensorX1*vectorS1(3)+force.forceSensorX2*vectorS2(3))/(force.forceSensorX1+force.forceSensorX2);
%     force.grfX_L=(force.forceSensorX1+force.forceSensorX2)*(cFX-cdpR(3))/(cdpL(3)-cdpR(3));
%     force.grfX_R=(force.forceSensorX1+force.forceSensorX2)*(cFX-cdpL(3))/(cdpR(3)-cdpL(3));
%     
%     cFZ=(force.forceSensorZ1*vectorS1(3)+force.forceSensorZ2*vectorS2(3))/(force.forceSensorZ1+force.forceSensorZ2);
%     force.grfZ_L=(force.forceSensorZ1+force.forceSensorZ2)*(cFZ-cdpR(3))/(cdpL(3)-cdpR(3));
%     force.grfZ_R=(force.forceSensorZ1+force.forceSensorZ2)*(cFZ-cdpL(3))/(cdpR(3)-cdpL(3));

      force.grfX_L=force.grfX/2;
      force.grfX_R=force.grfX/2;
      force.grfZ_L=force.grfZ/2;
      force.grfZ_R=force.grfZ/2;
end

clear -regexp ^vector cdpR cdpL cFX cFZ