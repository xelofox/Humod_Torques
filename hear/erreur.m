% load('Fxyz.mat');
% load('Fzyx.mat');
% load('Fxyz2.mat');
% load('Fzyx2.mat');
% 
% for 
% 
% 
% subplot(2,1,1);
% hold off
% plot(Fzyx);
% hold on
% plot(Fxyz);
% subplot(2,1,2);
% hold off
% plot(Fxyz2);
% hold on
% plot(Fzyx2);

load('Parameters.mat')
h=zeros(13,3);
h(1,1:3)=transpose(joints.absolutePosition.LNJ);
h(2,1:3)=transpose(joints.absolutePosition.SJ_L);
h(3,1:3)=transpose(joints.absolutePosition.SJ_R);
h(4,1:3)=transpose(joints.absolutePosition.EJ_L);
h(5,1:3)=transpose(joints.absolutePosition.EJ_R);
h(6,1:3)=transpose(joints.absolutePosition.ULJ);
h(7,1:3)=transpose(joints.absolutePosition.LLJ);
h(8,1:3)=transpose(joints.absolutePosition.HJ_L);
h(9,1:3)=transpose(joints.absolutePosition.HJ_R);
h(10,1:3)=transpose(joints.absolutePosition.KJ_L);
h(11,1:3)=transpose(joints.absolutePosition.KJ_R);
h(12,1:3)=transpose(joints.absolutePosition.AJ_L);
h(13,1:3)=transpose(joints.absolutePosition.AJ_R);

plot3(h(:,1),h(:,2),h(:,3),'*');
axis equal