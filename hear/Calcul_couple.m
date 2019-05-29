%% récupération des données
file='1.1.mat';
 load(file);
 load('c_footL.mat');
 load('c_footR.mat');
 load('R_footL0.mat');
 load('R_footR0.mat');
% load('Fa.mat');

q=(motion.trajectory.q);
dq=(motion.trajectory.dqdt);
ddq=(motion.trajectory.ddqddt);
Freact=[force.grfX_L; force.grfY_L; force.grfZ_L; force.grfX_R; force.grfY_R; force.grfZ_R];

syms pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R CXL CYL CZL CXR CYR CZR real;
syms dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R dCXL dCYL dCZL dCXR dCYR dCZR real;
syms ddpBJX ddpBJY ddpBJZ ddrBJX ddrBJY ddrBJZ ddrLNJX ddrLNJY ddrLNJZ ddrSJX_L ddrSJY_L ddrSJZ_L ddrSJX_R ddrSJY_R ddrSJZ_R ddrEJZ_L ddrEJZ_R ddrULJX ddrULJY ddrULJZ ddrLLJX ddrLLJZ ddrHJX_L ddrHJY_L ddrHJZ_L ddrHJX_R ddrHJY_R ddrHJZ_R ddrKJZ_L ddrKJZ_R ddrAJX_L ddrAJY_L ddrAJZ_L ddrAJX_R ddrAJY_R ddrAJZ_R ddCXL ddCYL ddCZL ddCXR ddCYR ddCZR real;

q_symb=[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R CXL CYL CZL CXR CYR CZR];
dq_symb=[dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R dCXL dCYL dCZL dCXR dCYR dCZR];
ddq_symb=[ddpBJX ddpBJY ddpBJZ ddrBJX ddrBJY ddrBJZ ddrLNJX ddrLNJY ddrLNJZ ddrSJX_L ddrSJY_L ddrSJZ_L ddrSJX_R ddrSJY_R ddrSJZ_R ddrEJZ_L ddrEJZ_R ddrULJX ddrULJY ddrULJZ ddrLLJX ddrLLJZ ddrHJX_L ddrHJY_L ddrHJZ_L ddrHJX_R ddrHJY_R ddrHJZ_R ddrKJZ_L ddrKJZ_R ddrAJX_L ddrAJY_L ddrAJZ_L ddrAJX_R ddrAJY_R ddrAJZ_R ddCXL ddCYL ddCZL ddCXR ddCYR ddCZR];

syms grfX_L grfY_L grfZ_L grfX_R grfY_R grfZ_R real;
FeL=[grfX_L grfY_L grfZ_L];
FeR=[grfX_R grfY_R grfZ_R];

%calcul des centres de pression des pieds au sol
center_pressure=zeros(6,1);
v_c_pressure=zeros(6,1);
a_c_pressure=zeros(6,1);
Tau=zeros(36+2*3,numel(q)); %30 DOF du corps+ 6pour la liaison avec le monde+ 2*3 pour les centres de pression des pieds au sol
%% Calcul des couples
for k=1:numel(q)
    k
    inter_center_pressure=c_pressure(k,force,motion,c_footL,c_footR,R_footL0,R_footR0);
    center_pressure(1:3)=inter_center_pressure(1,:);
    center_pressure(4:6)=inter_center_pressure(2,:);
    Tau(:,k)=subs(Fa, [q_symb dq_symb ddq_symb FeL FeR], transpose([q(:,k); center_pressure; dq(:,k); v_c_pressure; ddq(:,k); a_c_pressure; Freact(:,2*k)]));
end