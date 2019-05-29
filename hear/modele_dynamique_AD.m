%% M�nage
clear all;
close all;
clc;
%use subs(fcft, old, new)
%t = num2cell([1,2,3,4]);
%[a,b,c,d] = deal(t{:});
%% D�finition des variables et des param�tres du mod�le

%appeler Parameters.mat
load('Parameters.mat')
file='1.1.mat';
load(file);
'calcul des paramètres'
% Param�tres du mod�le
%positions liaison-centremasse
d_pelvis_LLJ_c=[pelvis.comX;pelvis.comY;pelvis.comZ];
d_abdomen_ULJ_c=[abdomen.comX;abdomen.comY;abdomen.comZ];
d_thorax_LNJ_c=[thorax.comX;thorax.comY;thorax.comZ];
d_upperArmR_SJR_c=[upperArm_R.comX;upperArm_R.comY;upperArm_R.comZ];
d_upperArmL_SJL_c=[upperArm_L.comX;upperArm_L.comY;upperArm_L.comZ];
d_lowerArmR_EJR_c=[lowerArm_R.comX;lowerArm_R.comY;lowerArm_R.comZ];
d_lowerArmL_EJL_c=[lowerArm_L.comX;lowerArm_L.comY;lowerArm_L.comZ];
d_thighR_HJR_c=[thigh_R.comX;thigh_R.comY;thigh_R.comZ];
d_thighL_HJL_c=[thigh_L.comX;thigh_L.comY;thigh_L.comZ];
d_shankR_KJR_c=[shank_R.comX;shank_R.comY;shank_R.comZ];
d_shankL_KJL_c=[shank_L.comX;shank_L.comY;shank_L.comZ];
d_footR_AJR_c=[foot_R.comX;foot_R.comY;foot_R.comZ];
d_footL_AJL_c=[foot_R.comX;foot_R.comY;foot_R.comZ];
d_head_LNJ_c=[head.comX;head.comY;head.comZ];

%distances inter-liaison
d_LLJ_ULJ=abdomen.relativePosition.LLJ;
d_ULJ_LNJ=[0;thorax.segmentLengthY;0]; %valeur probablement pas tout à fait exact mais non trouvée dans la doc
d_LNJ_SJR=thorax.relativePosition.SJ_R;
d_LNJ_SJL=thorax.relativePosition.SJ_L;
d_SJL_EJL=upperArm_L.relativePosition.EJ_L;
d_SJR_EJR=upperArm_R.relativePosition.EJ_R;
d_LLJ_HJL=pelvis.relativePosition.HJ_L;
d_HJL_KJL=thigh_L.relativePosition.KJ_L;
d_KJL_AJL=shank_L.relativePosition.AJ_L;
d_LLJ_HJR=pelvis.relativePosition.HJ_R;
d_HJR_KJR=thigh_R.relativePosition.KJ_R;
d_KJR_AJR=shank_R.relativePosition.AJ_R;

%masses
m_pelvis=pelvis.mass;
m_abdomen=abdomen.mass;
m_thorax=thorax.mass;
m_upperArmL=upperArm_L.mass;
m_lowerArmL=lowerArm_L.mass;
m_upperArmR=upperArm_R.mass;
m_lowerArmR=lowerArm_R.mass;
m_head=head.mass;
m_thighL=thigh_L.mass;
m_shankL=shank_L.mass;
m_footL=foot_L.mass;
m_thighR=thigh_R.mass;
m_shankR=shank_R.mass;
m_footR=foot_R.mass;

%Inertie
I_pelvis=I_mat(pelvis.moiXX,pelvis.moiYY,pelvis.moiZZ,pelvis.poiXY,pelvis.poiXZ,pelvis.poiYZ);
I_abdomen=I_mat(abdomen.moiXX,abdomen.moiYY,abdomen.moiZZ,abdomen.poiXY,abdomen.poiXZ,abdomen.poiYZ);
I_thorax=I_mat(thorax.moiXX,thorax.moiYY,thorax.moiZZ,thorax.poiXY,thorax.poiXZ,thorax.poiYZ);
I_upperArmL=I_mat(upperArm_L.moiXX,upperArm_L.moiYY,upperArm_L.moiZZ,upperArm_L.poiXY,upperArm_L.poiXZ,upperArm_L.poiYZ);
I_lowerArmL=I_mat(lowerArm_L.moiXX,lowerArm_L.moiYY,lowerArm_L.moiZZ,lowerArm_L.poiXY,lowerArm_L.poiXZ,lowerArm_L.poiYZ);
I_upperArmR=I_mat(upperArm_R.moiXX,upperArm_R.moiYY,upperArm_R.moiZZ,upperArm_R.poiXY,upperArm_R.poiXZ,upperArm_R.poiYZ);
I_lowerArmR=I_mat(lowerArm_R.moiXX,lowerArm_R.moiYY,lowerArm_R.moiZZ,lowerArm_R.poiXY,lowerArm_R.poiXZ,lowerArm_R.poiYZ);
I_head=I_mat(head.moiXX,head.moiYY,head.moiZZ,head.poiXY,head.poiXZ,head.poiYZ);
I_thighL=I_mat(thigh_L.moiXX,thigh_L.moiYY,thigh_L.moiZZ,thigh_L.poiXY,thigh_L.poiXZ,thigh_L.poiYZ);
I_shankL=I_mat(shank_L.moiXX,shank_L.moiYY,shank_L.moiZZ,shank_L.poiXY,shank_L.poiXZ,shank_L.poiYZ);
I_footL=I_mat(foot_L.moiXX,foot_L.moiYY,foot_L.moiZZ,foot_L.poiXY,foot_L.poiXZ,foot_L.poiYZ);
I_thighR=I_mat(thigh_R.moiXX,thigh_R.moiYY,thigh_R.moiZZ,thigh_R.poiXY,thigh_R.poiXZ,thigh_R.poiYZ);
I_shankR=I_mat(shank_R.moiXX,shank_R.moiYY,shank_R.moiZZ,shank_R.poiXY,shank_R.poiXZ,shank_R.poiYZ);
I_footR=I_mat(foot_R.moiXX,foot_R.moiYY,foot_R.moiZZ,foot_R.poiXY,foot_R.poiXZ,foot_R.poiYZ);

%% param�tres du mouvement et leurs d�riv�es
syms pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R CXL CYL CZL CXR CYR CZR real;
syms dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R dCXL dCYL dCZL dCXR dCYR dCZR real;
syms ddpBJX ddpBJY ddpBJZ ddrBJX ddrBJY ddrBJZ ddrLNJX ddrLNJY ddrLNJZ ddrSJX_L ddrSJY_L ddrSJZ_L ddrSJX_R ddrSJY_R ddrSJZ_R ddrEJZ_L ddrEJZ_R ddrULJX ddrULJY ddrULJZ ddrLLJX ddrLLJZ ddrHJX_L ddrHJY_L ddrHJZ_L ddrHJX_R ddrHJY_R ddrHJZ_R ddrKJZ_L ddrKJZ_R ddrAJX_L ddrAJY_L ddrAJZ_L ddrAJX_R ddrAJY_R ddrAJZ_R ddCXL ddCYL ddCZL ddCXR ddCYR ddCZR real;

q=[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R CXL CYL CZL CXR CYR CZR]';
dq=[dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R dCXL dCYL dCZL dCXR dCYR dCZR]';
ddq=[ddpBJX ddpBJY ddpBJZ ddrBJX ddrBJY ddrBJZ ddrLNJX ddrLNJY ddrLNJZ ddrSJX_L ddrSJY_L ddrSJZ_L ddrSJX_R ddrSJY_R ddrSJZ_R ddrEJZ_L ddrEJZ_R ddrULJX ddrULJY ddrULJZ ddrLLJX ddrLLJZ ddrHJX_L ddrHJY_L ddrHJZ_L ddrHJX_R ddrHJY_R ddrHJZ_R ddrKJZ_L ddrKJZ_R ddrAJX_L ddrAJY_L ddrAJZ_L ddrAJX_R ddrAJY_R ddrAJZ_R ddCXL ddCYL ddCZL ddCXR ddCYR ddCZR;]';

dq=[dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R]';
q=[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R]';



%% actions de liaison et actions ext�rieures
%syms FpBJX FpBJY FpBJZ TrBJX TrBJY TrBJZ TrLNJX TrLNJY TrLNJZ TrSJX_L TrSJY_L TrSJZ_L TrSJX_R TrSJY_R TrSJZ_R TrEJZ_L TrEJZ_R TrULJX TrULJY TrULJZ TrLLJX TrLLJZ TrHJX_L TrHJY_L TrHJZ_L TrHJX_R TrHJY_R TrHJZ_R TrKJZ_L TrKJZ_R TrAJX_L TrAJY_L TrAJZ_L TrAJX_R TrAJY_R TrAJZ_R real;

syms grfX_L grfY_L grfZ_L grfX_R grfY_R grfZ_R real; % actions ext�rieures
g=[0 9.81 0];
%Fe=[Fx Fy 0]';
FeR=[grfX_R; grfY_R; grfZ_R];
FeL=[grfX_L; grfY_L; grfZ_L];




%% introduction des valeurs interessantes
q=(motion.trajectory.q);
dq=(motion.trajectory.dqdt);
ddq=(motion.trajectory.ddqddt);

%% boucle englobant l'implémentation de Lagrange
for k=1:numel(q)
    
t = num2cell(transpose([q(:,k);dq(:,k)]));
[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R]=deal(t{:});
[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R]=ainit(pBJX, pBJY, pBJZ, rBJX, rBJY, rBJZ, rLNJX, rLNJY, rLNJZ, rSJX_L, rSJY_L, rSJZ_L, rSJX_R, rSJY_R, rSJZ_R, rEJZ_L, rEJZ_R, rULJX, rULJY, rULJZ, rLLJX, rLLJZ, rHJX_L, rHJY_L, rHJZ_L, rHJX_R, rHJY_R, rHJZ_R, rKJZ_L, rKJZ_R, rAJX_L, rAJY_L, rAJZ_L, rAJX_R, rAJY_R, rAJZ_R,dpBJX, dpBJY, dpBJZ, drBJX, drBJY, drBJZ, drLNJX, drLNJY, drLNJZ, drSJX_L, drSJY_L, drSJZ_L, drSJX_R, drSJY_R, drSJZ_R, drEJZ_L, drEJZ_R, drULJX, drULJY, drULJZ, drLLJX, drLLJZ, drHJX_L, drHJY_L, drHJZ_L, drHJX_R, drHJY_R, drHJZ_R, drKJZ_L, drKJZ_R, drAJX_L, drAJY_L, drAJZ_L, drAJX_R, drAJY_R, drAJZ_R,2);
% t = num2cell(transpose(q(:,k)));
% [pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R]=deal(t{:});
% [pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R ]=ainit(pBJX, pBJY, pBJZ, rBJX, rBJY, rBJZ, rLNJX, rLNJY, rLNJZ, rSJX_L, rSJY_L, rSJZ_L, rSJX_R, rSJY_R, rSJZ_R, rEJZ_L, rEJZ_R, rULJX, rULJY, rULJZ, rLLJX, rLLJZ, rHJX_L, rHJY_L, rHJZ_L, rHJX_R, rHJY_R, rHJZ_R, rKJZ_L, rKJZ_R, rAJX_L, rAJY_L, rAJZ_L, rAJX_R, rAJY_R, rAJZ_R,2);
%% Positions et vitesses des centres de masse
%position
'calcul des positions'
R_pelvis0=rot_z(rBJZ)*rot_y(rBJY)*rot_x(rBJX);
pos_LLJ=[pBJX; pBJY; pBJZ];
c_pelvis=pos_LLJ+R_pelvis0*d_pelvis_LLJ_c; %centre de masse pelvis

R_abdomen0=rot_z(rLLJZ)*rot_x(rLLJX)*R_pelvis0;
pos_ULJ=pos_LLJ+R_abdomen0*d_LLJ_ULJ;
c_abdomen=pos_ULJ+R_abdomen0*d_abdomen_ULJ_c; %centre de masse abdomen

R_thorax0=rot_z(rULJZ)*rot_y(rULJY)*rot_x(rULJX)*R_abdomen0; 
pos_LNJ=pos_ULJ+R_thorax0*d_ULJ_LNJ;
c_thorax=pos_LNJ+R_thorax0*d_thorax_LNJ_c; %centre de masse thorax

R_head0=rot_z(rLNJZ)*rot_y(rLNJY)*rot_x(rLNJX)*R_thorax0;
c_head=pos_LNJ+R_head0*d_head_LNJ_c; %centre de masse tête

R_upperArmL0=rot_z(rSJZ_L)*rot_y(rSJY_L)*rot_x(rSJX_L)*R_thorax0;
pos_SJL=pos_LNJ+R_thorax0*d_LNJ_SJL;
c_upperArmL=pos_SJL+R_upperArmL0*d_upperArmL_SJL_c; %centre de masse upperArmL

R_lowerArmL0=rot_z(rEJZ_L)*R_upperArmL0;
pos_EJL=pos_SJL+R_upperArmL0*d_SJL_EJL;
c_lowerArmL=pos_EJL+R_lowerArmL0*d_lowerArmL_EJL_c; %centre de masse lowerArmL

R_upperArmR0=rot_z(rSJZ_R)*rot_y(rSJY_R)*rot_x(rSJX_R)*R_thorax0;
pos_SJR=pos_LNJ+R_thorax0*d_LNJ_SJR;
c_upperArmR=pos_SJR+R_upperArmR0*d_upperArmR_SJR_c; %centre de masse upperArmL

R_lowerArmR0=rot_z(rEJZ_R)*R_upperArmR0;
pos_EJR=pos_SJR+R_upperArmR0*d_SJR_EJR;
c_lowerArmR=pos_EJR+R_lowerArmR0*d_lowerArmR_EJR_c; %centre de masse lowerArmR

R_thighL0=rot_z(rHJZ_L)*rot_y(rHJY_L)*rot_x(rHJX_L);
pos_HJL=pos_LLJ+R_pelvis0*d_LLJ_HJL;
c_thighL=pos_HJL+R_thighL0*d_thighL_HJL_c; %centre de masse de la cuisse gauche

R_shankL0=rot_z(rKJZ_L)*R_thighL0;
pos_KJL=pos_HJL+R_thighL0*d_HJL_KJL;
c_shankL=pos_KJL+R_shankL0*d_shankL_KJL_c; %centre de masse du jarret gauche

R_footL0=rot_z(rAJZ_L)*rot_y(rAJY_L)*rot_x(rAJX_L);
pos_AJL=pos_KJL+R_shankL0*d_KJL_AJL;
c_footL=pos_AJL+R_footL0*d_footL_AJL_c; %centre de masse du pied gauche

R_thighR0=rot_z(rHJZ_R)*rot_y(rHJY_R)*rot_x(rHJX_R);
pos_HJR=pos_LLJ+R_pelvis0*d_LLJ_HJR;
c_thighR=pos_HJR+R_thighR0*d_thighR_HJR_c; %centre de masse de la cuisse droite

R_shankR0=rot_z(rKJZ_R)*R_thighR0;
pos_KJR=pos_HJR+R_thighR0*d_HJR_KJR;
c_shankR=pos_KJR+R_shankR0*d_shankR_KJR_c; %centre de masse du jarret droit

R_footR0=rot_z(rAJZ_R)*rot_y(rAJY_R)*rot_x(rAJX_R);
pos_AJR=pos_KJR+R_shankR0*d_KJR_AJR;
c_footR=pos_AJR+R_footR0*d_footR_AJR_c; %centre de masse du pied droit

'calcul des vitesses'
%vitesse
v_pelvis=ajac(c_pelvis)*dq;
v_abdomen=ajac(c_abdomen)*dq;
v_thorax=ajac(c_thorax)*dq;
v_head=ajac(c_head)*dq;
v_upperArmL=ajac(c_upperArmL)*dq;
v_lowerArmL=ajac(c_lowerArmL)*dq;
v_upperArmR=ajac(c_upperArmR)*dq;
v_lowerArmR=ajac(c_lowerArmR)*dq;
v_thighL=ajac(c_thighL)*dq;
v_shankL=ajac(c_shankL)*dq;
v_footL=ajac(c_footL)*dq;
v_thighR=ajac(c_thighR)*dq;
v_shankR=ajac(c_shankR)*dq;
v_footR=ajac(c_footR)*dq;





%% Energie cin�tique
'calcul de T'
T_pelvis=0.5*m_pelvis*conj(v_pelvis')*v_pelvis+0.5*[rBJX rBJY rBJZ]*(I_pelvis*[rBJX; rBJY; rBJZ]);
%T_pelvis=simplify(T_pelvis);
T_abdomen=0.5*m_abdomen*conj(v_abdomen')*v_abdomen+0.5*[rLLJX 0 rLLJZ]*(I_abdomen*[rLLJX; 0; rLLJZ]);
%T_abdomen=simplify(T_abdomen);
T_thorax=0.5*m_thorax*conj(v_thorax')*v_thorax+0.5*[rULJX rULJY rULJZ]*(I_thorax*[rULJX; rULJY; rULJZ]);
%T_thorax=simplify(T_thorax);
T_head=0.5*m_head*conj(v_head')*v_head+0.5*[rLNJX rLNJZ rLNJZ]*(I_head*[rLNJX; rLNJZ; rLNJZ]);
%T_head=simplify(T_head);
T_upperArmL=0.5*m_upperArmL*conj(v_upperArmL')*v_upperArmL+0.5*[rSJX_L rSJY_L rSJZ_L]*(I_upperArmL*[rSJX_L; rSJY_L; rSJZ_L]);
%T_upperArmL=simplify(T_upperArmL);
T_lowerArmL=0.5*m_lowerArmL*conj(v_lowerArmL')*v_lowerArmL+0.5*[0 0 rEJZ_L]*(I_lowerArmL*[0; 0; rEJZ_L]);
%T_lowerArmL=simplify(T_lowerArmL);
T_upperArmR=0.5*m_upperArmR*conj(v_upperArmR')*v_upperArmR+0.5*[rSJX_R rSJY_R rSJZ_R]*(I_upperArmR*[rSJX_R; rSJY_R; rSJZ_R]);
%T_upperArmR=simplify(T_upperArmR);
T_lowerArmR=0.5*m_lowerArmR*conj(v_lowerArmR')*v_lowerArmR+0.5*[0 0 rEJZ_R]*(I_lowerArmR*[0; 0; rEJZ_R]);
%T_lowerArmR=simplify(T_lowerArmR);
T_thighL=0.5*m_thighL*conj(v_thighL')*v_thighL+0.5*[rHJX_L rHJY_L rHJZ_L]*(I_thighL*[rHJX_L; rHJY_L; rHJZ_L]);
%T_thighL=simplify(T_thighL);
T_shankL=0.5*m_shankL*conj(v_shankL')*v_shankL+0.5*[0 0 rKJZ_L]*(I_shankL*[0; 0; rKJZ_L]);
%T_shankL=simplify(T_shankL);
T_footL=0.5*m_footL*conj(v_footL')*v_footL+0.5*[rAJX_L rAJY_L rAJZ_L]*(I_footL*[rAJX_L; rAJY_L; rAJZ_L]);
%T_footL=simplify(T_footL);
T_thighR=0.5*m_thighR*conj(v_thighR')*v_thighR+0.5*[rHJX_R rHJY_R rHJZ_R]*(I_thighR*[rHJX_R; rHJY_R; rHJZ_R]);
%T_thighR=simpRify(T_thighR);
T_shankR=0.5*m_shankR*conj(v_shankR')*v_shankR+0.5*[0 0 rKJZ_R]*(I_shankR*[0; 0; rKJZ_R]);
%T_shankR=simpRify(T_shankR);
T_footR=0.5*m_footR*conj(v_footR')*v_footR+0.5*[rAJX_R rAJY_R rAJZ_R]*(I_footR*[rAJX_R; rAJY_R; rAJZ_R]);
%T_footR=simpRify(T_footR);

T = T_pelvis+T_abdomen+T_thorax+T_head+T_upperArmL+T_lowerArmL+T_upperArmR+T_lowerArmR+T_thighL+T_shankL+T_footL+T_thighR+T_shankR+T_footR ; %�nergie cin�tique du syst�me
%T = simplify(T);

%% Energie potentiel
'Calcul de EP'
EP_pelvis=m_pelvis*g*c_pelvis;
EP_abdomen=m_abdomen*g*c_abdomen;
EP_thorax=m_thorax*g*c_thorax;
EP_head=m_head*g*c_head;
EP_upperArmL=m_upperArmL*g*c_upperArmL;
EP_lowerArmL=m_lowerArmL*g*c_lowerArmL;
EP_upperArmL=m_upperArmL*g*c_upperArmL;
EP_lowerArmL=m_lowerArmL*g*c_lowerArmL;
EP_thighL=m_thighL*g*c_thighL;
EP_shankL=m_shankL*g*c_shankL;
EP_footL=m_footL*g*c_footL;
EP_thighR=m_thighR*g*c_thighR;
EP_shankR=m_shankR*g*c_shankR;
EP_footR=m_footR*g*c_footR;

EP=EP_pelvis+EP_abdomen+EP_thorax+EP_head+EP_upperArmL+EP_lowerArmL+EP_upperArmL+EP_lowerArmL+EP_thighL+EP_shankL+EP_footL+EP_thighR+EP_shankR+EP_footR;
%% Obtention de H
'Calcul de H'
%Htemp=simplify(gradient(T,dq));
HTemp=gradient(T,dq);
%H=simplify(jacobian(Htemp,dq));
H=jacobian(HTemp,dq);
%% obtention de C
nq=length(dq);
syms C;
'Calcul de C'
for i=1:nq
    i
    for j=1:nq
        C(i,j)=0;
        for k=1:nq
            C(i,j)=C(i,j)+0.5*dq(k)*(diff(H(i,j),q(k))+diff(H(i,k),q(j))-diff(H(j,k),q(i)));
        end
    end
end
%C=simplify(C);

%% Obtention de G
'Calcul de G'
G=gradient(EP,q);
%G=simplify(G);
%% Calcul de F
% point d'application de Fe exprim� dans R0
'Calcul de Qfe'
reR=c_footR+R_footR0*[CXR; CYR; CZR];
reL=c_footL+R_footL0*[CXL; CYL; CZL];

QfeR=jacobian(reR,q)'*FeR;
QfeL=jacobian(reL,q)'*FeL;
Qfe=QfeL+QfeR;

%% Dynamique inverse
Fa=H*ddq+C*dq+G-Qfe; %=[tau1 tau2]
%Fa= simplify(Fa);


end 
%% Calcul des acc�l�rations
% Tau=[tau1 tau2]';
% dddq= simplify(inv(H)*(Tau-C*dq-G+Qfe));
