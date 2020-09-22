%% Clear
% clear all;
% close all;
% clc;
%use subs(fcft, old, new)
%% model parameters and motion loading
% Code explained in part 6.2
    %6.2.1 : Data entry from line 13 to 106
    %6.2.2 : Data entry from line 13 to 106
    %6.2.3 : Data entry from line 13 to 106
    %6.2.4 : Data entry from line 13 to 106

load('Parameters.mat')
Motion="1.2";
file=strcat(Motion,".mat");
load(file);

if file=="6.mat"
    load('6_force.mat');
end



%% Model parameters use
%joint-center of mass positions 
d_pelvis_LLJ_c=[pelvis.comX;pelvis.comY;pelvis.comZ]*1e-3;
d_abdomen_ULJ_c=[abdomen.comX;abdomen.comY;abdomen.comZ]*1e-3;
d_thorax_LNJ_c=[thorax.comX;thorax.comY;thorax.comZ]*1e-3;
d_upperArmR_SJR_c=[upperArm_R.comX;upperArm_R.comY;upperArm_R.comZ]*1e-3;
d_upperArmL_SJL_c=[upperArm_L.comX;upperArm_L.comY;upperArm_L.comZ]*1e-3;
d_lowerArmR_EJR_c=[lowerArm_R.comX;lowerArm_R.comY;lowerArm_R.comZ]*1e-3;
d_lowerArmL_EJL_c=[lowerArm_L.comX;lowerArm_L.comY;lowerArm_L.comZ]*1e-3;
d_thighR_HJR_c=[thigh_R.comX;thigh_R.comY;thigh_R.comZ]*1e-3;
d_thighL_HJL_c=[thigh_L.comX;thigh_L.comY;thigh_L.comZ]*1e-3;
d_shankR_KJR_c=[shank_R.comX;shank_R.comY;shank_R.comZ]*1e-3;
d_shankL_KJL_c=[shank_L.comX;shank_L.comY;shank_L.comZ]*1e-3;
d_footR_AJR_c=[foot_R.comX;foot_R.comY;foot_R.comZ]*1e-3;
d_footL_AJL_c=[foot_R.comX;foot_R.comY;foot_R.comZ]*1e-3;
d_head_LNJ_c=[head.comX;head.comY;head.comZ]*1e-3;

%inter-joint distances
d_LLJ_ULJ=-abdomen.relativePosition.LLJ*1e-3;
d_ULJ_LNJ=[0;thorax.segmentLengthY;0]*1e-3; 
d_LNJ_SJR=thorax.relativePosition.SJ_R*1e-3;
d_LNJ_SJL=thorax.relativePosition.SJ_L*1e-3;
d_SJL_EJL=upperArm_L.relativePosition.EJ_L*1e-3;
d_SJR_EJR=upperArm_R.relativePosition.EJ_R*1e-3;
d_LLJ_HJL=pelvis.relativePosition.HJ_L*1e-3;
d_HJL_KJL=thigh_L.relativePosition.KJ_L*1e-3;
d_KJL_AJL=shank_L.relativePosition.AJ_L*1e-3;
d_LLJ_HJR=pelvis.relativePosition.HJ_R*1e-3;
d_HJR_KJR=thigh_R.relativePosition.KJ_R*1e-3;
d_KJR_AJR=shank_R.relativePosition.AJ_R*1e-3;

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

%Inertia
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

%% movement parameters and derivative

q=(motion.trajectory.q);
dq=(motion.trajectory.dqdt);
ddq=(motion.trajectory.ddqddt);


%% gravity

g=[0; -9.81; 0];


%% loop
L=length(q);
for k=1:L
    if mod(k,100)==0
        disp(int2str(k)+"/"+int2str(L))
    end
%% loading joint motion
    i=2*(k); %  force indice
    t = num2cell(transpose([q(:,k);dq(:,k)]));
    [pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R]=deal(t{:});
    t=num2cell(transpose([ddq(:,k)]));
    [ddpBJX ddpBJY ddpBJZ ddrBJX ddrBJY ddrBJZ ddrLNJX ddrLNJY ddrLNJZ ddrSJX_L ddrSJY_L ddrSJZ_L ddrSJX_R ddrSJY_R ddrSJZ_R ddrEJZ_L ddrEJZ_R ddrULJX ddrULJY ddrULJZ ddrLLJX ddrLLJZ ddrHJX_L ddrHJY_L ddrHJZ_L ddrHJX_R ddrHJY_R ddrHJZ_R ddrKJZ_L ddrKJZ_R ddrAJX_L ddrAJY_L ddrAJZ_L ddrAJX_R ddrAJY_R ddrAJZ_R]=deal(t{:});

%% from 1 to nb : kinematic

    %world to pelvis
    R_pelvis0=rot_z(rBJZ)*rot_y(rBJY)*rot_x(rBJX); % orientation of the pelvis
    pos_BJ=[pBJX; pBJY; pBJZ]*1e-3;

    u_pelvis_x=[1; 0; 0];
    u_pelvis_y=rot_x(rBJX)*[0; 1; 0];
    u_pelvis_z=rot_y(rBJY)*rot_x(rBJX)*[0; 0; 1]; % orientation of the last rotation of the joint

    ksi_pelvis_x=[dpBJX*1e-3; dpBJY*1e-3; dpBJZ*1e-3; 0; 0; 0]+[cross(pos_BJ,u_pelvis_x); u_pelvis_x]*drBJX;
    ksi_pelvis_y=ksi_pelvis_x+[cross(pos_BJ,u_pelvis_y); u_pelvis_y]*drBJY;
    ksi_pelvis_z=ksi_pelvis_y+[cross(pos_BJ,u_pelvis_z); u_pelvis_z]*drBJZ; % determination of the spatial velocity vector

    dksi_pelvis_x=[ddpBJX*1e-3; ddpBJY*1e-3; ddpBJZ*1e-3; 0; 0; 0]+ksi_cross(ksi_pelvis_x)*[cross(pos_BJ,u_pelvis_x); u_pelvis_x]*drBJX+[cross(pos_BJ,u_pelvis_x); u_pelvis_x]*ddrBJX;
    dksi_pelvis_y=dksi_pelvis_x+ksi_cross(ksi_pelvis_y)*[cross(pos_BJ,u_pelvis_y); u_pelvis_y]*drBJY+[cross(pos_BJ,u_pelvis_y); u_pelvis_y]*ddrBJY;
    dksi_pelvis_z=dksi_pelvis_y+ksi_cross(ksi_pelvis_z)*[cross(pos_BJ,u_pelvis_z); u_pelvis_z]*drBJZ+[cross(pos_BJ,u_pelvis_z); u_pelvis_z]*ddrBJZ; %determination of the spatial acceleration vector
    
     
    %pelvis to abdomen
    R_abdomen0=rot_z(rLLJZ)*rot_x(rLLJX)*R_pelvis0;
    pos_LLJ=pos_BJ;
    
    
    u_abdomen_x=R_pelvis0*[1; 0; 0];
    u_abdomen_z=rot_x(rLLJX)*R_pelvis0*[0; 0; 1];

    ksi_abdomen_x=ksi_pelvis_z+[cross(pos_LLJ,u_abdomen_x); u_abdomen_x]*drLLJX;
    ksi_abdomen_z=ksi_abdomen_x+[cross(pos_LLJ,u_abdomen_z); u_abdomen_z]*drLLJZ;

    dksi_abdomen_x=dksi_pelvis_z+ksi_cross(ksi_abdomen_x)*[cross(pos_LLJ,u_abdomen_x); u_abdomen_x]*drLLJX+[cross(pos_LLJ,u_abdomen_x); u_abdomen_x]*ddrLLJX;
    dksi_abdomen_z=dksi_abdomen_x+ksi_cross(ksi_abdomen_z)*[cross(pos_LLJ,u_abdomen_z); u_abdomen_z]*drLLJZ+[cross(pos_LLJ,u_abdomen_z); u_abdomen_z]*ddrLLJZ;
    
    
    %abdomen to thorax    
    R_thorax0=rot_z(rULJZ)*rot_y(rULJY)*rot_x(rULJX)*R_abdomen0;
    pos_ULJ=pos_LLJ+R_abdomen0*d_LLJ_ULJ;

    u_thorax_x=R_abdomen0*[1; 0; 0];
    u_thorax_y=rot_x(rULJX)*R_abdomen0*[0; 1; 0];
    u_thorax_z=rot_y(rULJY)*rot_x(rULJX)*R_abdomen0*[0; 0; 1];

    ksi_thorax_x=ksi_abdomen_z+[cross(pos_ULJ,u_thorax_x); u_thorax_x]*drULJX;
    ksi_thorax_y=ksi_thorax_x+[cross(pos_ULJ,u_thorax_y); u_thorax_y]*drULJY;
    ksi_thorax_z=ksi_thorax_y+[cross(pos_ULJ,u_thorax_z); u_thorax_z]*drULJZ;

    dksi_thorax_x=dksi_abdomen_z+ksi_cross(ksi_thorax_x)*[cross(pos_ULJ,u_thorax_x); u_thorax_x]*drULJX+[cross(pos_ULJ,u_thorax_x); u_thorax_x]*ddrULJX;
    dksi_thorax_y=dksi_thorax_x+ksi_cross(ksi_thorax_y)*[cross(pos_ULJ,u_thorax_y); u_thorax_y]*drULJY+[cross(pos_ULJ,u_thorax_y); u_thorax_y]*ddrULJY;
    dksi_thorax_z=dksi_thorax_y+ksi_cross(ksi_thorax_z)*[cross(pos_ULJ,u_thorax_z); u_thorax_z]*drULJZ+[cross(pos_ULJ,u_thorax_z); u_thorax_z]*ddrULJZ;
    
    
    %thorax to head
    R_head0=rot_z(rLNJZ)*rot_y(rLNJY)*rot_x(rLNJX)*R_thorax0;
    pos_LNJ=pos_ULJ+R_thorax0*d_ULJ_LNJ;
    
    u_head_x=R_thorax0*[1; 0; 0];
    u_head_y=rot_x(rLNJX)*R_thorax0*[0; 1; 0];
    u_head_z=rot_y(rLNJY)*rot_x(rLNJX)*R_thorax0*[0; 0; 1];

    ksi_head_x=ksi_thorax_z+[cross(pos_LNJ,u_head_x); u_head_x]*drLNJX;
    ksi_head_y=ksi_head_x+[cross(pos_LNJ,u_head_y); u_head_y]*drLNJY;
    ksi_head_z=ksi_head_y+[cross(pos_LNJ,u_head_z); u_head_z]*drLNJZ;

    dksi_head_x=dksi_thorax_z+ksi_cross(ksi_head_x)*[cross(pos_LNJ,u_head_x); u_head_x]*drLNJX+[cross(pos_LNJ,u_head_x); u_head_x]*ddrLNJX;
    dksi_head_y=dksi_head_x+ksi_cross(ksi_head_y)*[cross(pos_LNJ,u_head_y); u_head_y]*drLNJY+[cross(pos_LNJ,u_head_y); u_head_y]*ddrLNJY;
    dksi_head_z=dksi_head_y+ksi_cross(ksi_head_z)*[cross(pos_LNJ,u_head_z); u_head_z]*drLNJZ+[cross(pos_LNJ,u_head_z); u_head_z]*ddrLNJZ;
    
    
    %thorax to upperArmL
    R_upperArmL0=rot_z(rSJZ_L)*rot_y(rSJY_L)*rot_x(rSJX_L)*R_thorax0;
    pos_SJL=pos_LNJ+R_thorax0*d_LNJ_SJL;
    
    u_upperArmL_x=R_thorax0*[1; 0; 0];
    u_upperArmL_y=rot_x(rSJX_L)*R_thorax0*[0; 1; 0];
    u_upperArmL_z=rot_y(rSJY_L)*rot_x(rSJX_L)*R_thorax0*[0; 0; 1];

    ksi_upperArmL_x=ksi_thorax_z+[cross(pos_SJL,u_upperArmL_x); u_upperArmL_x]*drSJX_L;
    ksi_upperArmL_y=ksi_upperArmL_x+[cross(pos_SJL,u_upperArmL_y); u_upperArmL_y]*drSJY_L;
    ksi_upperArmL_z=ksi_upperArmL_y+[cross(pos_SJL,u_upperArmL_z); u_upperArmL_z]*drSJZ_L;

    dksi_upperArmL_x=dksi_thorax_z+ksi_cross(ksi_upperArmL_x)*[cross(pos_SJL,u_upperArmL_x); u_upperArmL_x]*drSJX_L+[cross(pos_SJL,u_upperArmL_x); u_upperArmL_x]*ddrSJX_L;
    dksi_upperArmL_y=dksi_upperArmL_x+ksi_cross(ksi_upperArmL_y)*[cross(pos_SJL,u_upperArmL_y); u_upperArmL_y]*drSJY_L+[cross(pos_SJL,u_upperArmL_y); u_upperArmL_y]*ddrSJY_L;
    dksi_upperArmL_z=dksi_upperArmL_y+ksi_cross(ksi_upperArmL_z)*[cross(pos_SJL,u_upperArmL_z); u_upperArmL_z]*drSJZ_L+[cross(pos_SJL,u_upperArmL_z); u_upperArmL_z]*ddrSJZ_L;
    
    
    %upperArmL to lowerArmL
    R_lowerArmL0=rot_z(rEJZ_L)*R_upperArmL0;
    pos_EJL=pos_SJL+R_upperArmL0*d_SJL_EJL;
    
    u_lowerArmL_z=R_upperArmL0*[0; 0; 1];

    ksi_lowerArmL_z=ksi_upperArmL_z+[cross(pos_EJL,u_lowerArmL_z); u_lowerArmL_z]*drEJZ_L;

    dksi_lowerArmL_z=dksi_upperArmL_z+ksi_cross(ksi_lowerArmL_z)*[cross(pos_EJL,u_lowerArmL_z); u_lowerArmL_z]*drEJZ_L+[cross(pos_EJL,u_lowerArmL_z); u_lowerArmL_z]*ddrEJZ_L;    
    
    
    %thorax to upperArmR
    R_upperArmR0=rot_z(rSJZ_R)*rot_y(rSJY_R)*rot_x(rSJX_R)*R_thorax0;
    pos_SJR=pos_LNJ+R_thorax0*d_LNJ_SJR;
    
    u_upperArmR_x=R_thorax0*[1; 0; 0];
    u_upperArmR_y=rot_x(rSJX_R)*R_thorax0*[0; 1; 0];
    u_upperArmR_z=rot_y(rSJY_R)*rot_x(rSJX_R)*R_thorax0*[0; 0; 1];

    ksi_upperArmR_x=ksi_thorax_z+[cross(pos_SJR,u_upperArmR_x); u_upperArmR_x]*drSJX_R;
    ksi_upperArmR_y=ksi_upperArmR_x+[cross(pos_SJR,u_upperArmR_y); u_upperArmR_y]*drSJY_R;
    ksi_upperArmR_z=ksi_upperArmR_y+[cross(pos_SJR,u_upperArmR_z); u_upperArmR_z]*drSJZ_R;

    dksi_upperArmR_x=dksi_thorax_z+ksi_cross(ksi_upperArmR_x)*[cross(pos_SJR,u_upperArmR_x); u_upperArmR_x]*drSJX_R+[cross(pos_SJR,u_upperArmR_x); u_upperArmR_x]*ddrSJX_R;
    dksi_upperArmR_y=dksi_upperArmR_x+ksi_cross(ksi_upperArmR_y)*[cross(pos_SJR,u_upperArmR_y); u_upperArmR_y]*drSJY_R+[cross(pos_SJR,u_upperArmR_y); u_upperArmR_y]*ddrSJY_R;
    dksi_upperArmR_z=dksi_upperArmR_y+ksi_cross(ksi_upperArmR_z)*[cross(pos_SJR,u_upperArmR_z); u_upperArmR_z]*drSJZ_R+[cross(pos_SJR,u_upperArmR_z); u_upperArmR_z]*ddrSJZ_R;
    
    
    %upperArmR to lowerArmR
    R_lowerArmR0=rot_z(rEJZ_R)*R_upperArmR0;
    pos_EJR=pos_SJR+R_upperArmR0*d_SJR_EJR;
    
    u_lowerArmR_z=R_upperArmR0*[0; 0; 1];

    ksi_lowerArmR_z=ksi_upperArmR_z+[cross(pos_EJR,u_lowerArmR_z); u_lowerArmR_z]*drEJZ_R;

    dksi_lowerArmR_z=dksi_upperArmR_z+ksi_cross(ksi_lowerArmR_z)*[cross(pos_EJR,u_lowerArmR_z); u_lowerArmR_z]*drEJZ_R+[cross(pos_EJR,u_lowerArmR_z); u_lowerArmR_z]*ddrEJZ_R;    
    
    
    %pelvis to thighL
    R_thighL0=rot_z(rHJZ_L)*rot_y(rHJY_L)*rot_x(rHJX_L)*R_pelvis0;
    pos_HJL=pos_LLJ+R_pelvis0*d_LLJ_HJL;
    
    u_thighL_x=R_pelvis0*[1; 0; 0];
    u_thighL_y=rot_x(rHJX_L)*R_pelvis0*[0; 1; 0];
    u_thighL_z=rot_y(rHJY_L)*rot_x(rHJX_L)*R_pelvis0*[0; 0; 1];

    ksi_thighL_x=ksi_pelvis_z+[cross(pos_HJL,u_thighL_x); u_thighL_x]*drHJX_L;
    ksi_thighL_y=ksi_thighL_x+[cross(pos_HJL,u_thighL_y); u_thighL_y]*drHJY_L;
    ksi_thighL_z=ksi_thighL_y+[cross(pos_HJL,u_thighL_z); u_thighL_z]*drHJZ_L;

    dksi_thighL_x=dksi_pelvis_z+ksi_cross(ksi_thighL_x)*[cross(pos_HJL,u_thighL_x); u_thighL_x]*drHJX_L+[cross(pos_HJL,u_thighL_x); u_thighL_x]*ddrHJX_L;
    dksi_thighL_y=dksi_thighL_x+ksi_cross(ksi_thighL_y)*[cross(pos_HJL,u_thighL_y); u_thighL_y]*drHJY_L+[cross(pos_HJL,u_thighL_y); u_thighL_y]*ddrHJY_L;
    dksi_thighL_z=dksi_thighL_y+ksi_cross(ksi_thighL_z)*[cross(pos_HJL,u_thighL_z); u_thighL_z]*drHJZ_L+[cross(pos_HJL,u_thighL_z); u_thighL_z]*ddrHJZ_L;

    
    % thighL to shankL
    R_shankL0=rot_z(rKJZ_L)*R_thighL0;
    pos_KJL=pos_HJL+R_thighL0*d_HJL_KJL;
    
    u_shankL_z=R_thighL0*[0; 0; 1];

    ksi_shankL_z=ksi_thighL_z+[cross(pos_KJL,u_shankL_z); u_shankL_z]*drKJZ_L;

    dksi_shankL_z=dksi_thighL_z+ksi_cross(ksi_shankL_z)*[cross(pos_KJL,u_shankL_z); u_shankL_z]*drKJZ_L+[cross(pos_KJL,u_shankL_z); u_shankL_z]*ddrKJZ_L;

    
    % shankL to footL
    R_footL0=rot_z(rAJZ_L)*rot_y(rAJY_L)*rot_x(rAJX_L)*R_shankL0;
    pos_AJL=pos_KJL+R_shankL0*d_KJL_AJL;

    u_footL_x=R_shankL0*[1; 0; 0];
    u_footL_y=rot_x(rAJX_L)*R_shankL0*[0; 1; 0];
    u_footL_z=rot_y(rAJY_L)*rot_x(rAJX_L)*R_shankL0*[0; 0; 1];

    ksi_footL_x=ksi_shankL_z+[cross(pos_AJL,u_footL_x); u_footL_x]*drAJX_L;
    ksi_footL_y=ksi_footL_x+[cross(pos_AJL,u_footL_y); u_footL_y]*drAJY_L;
    ksi_footL_z=ksi_footL_y+[cross(pos_AJL,u_footL_z); u_footL_z]*drAJZ_L;

    dksi_footL_x=dksi_shankL_z+ksi_cross(ksi_footL_x)*[cross(pos_AJL,u_footL_x); u_footL_x]*drAJX_L+[cross(pos_AJL,u_footL_x); u_footL_x]*ddrAJX_L;
    dksi_footL_y=dksi_footL_x+ksi_cross(ksi_footL_y)*[cross(pos_AJL,u_footL_y); u_footL_y]*drAJY_L+[cross(pos_AJL,u_footL_y); u_footL_y]*ddrAJY_L;
    dksi_footL_z=dksi_footL_y+ksi_cross(ksi_footL_z)*[cross(pos_AJL,u_footL_z); u_footL_z]*drAJZ_L+[cross(pos_AJL,u_footL_z); u_footL_z]*ddrAJZ_L;
    
    
    %pelvis to thighR
    R_thighR0=rot_z(rHJZ_R)*rot_y(rHJY_R)*rot_x(rHJX_R)*R_pelvis0;
    pos_HJR=pos_LLJ+R_pelvis0*d_LLJ_HJR;
    
    u_thighR_x=R_pelvis0*[1; 0; 0];
    u_thighR_y=rot_x(rHJX_R)*R_pelvis0*[0; 1; 0];
    u_thighR_z=rot_y(rHJY_R)*rot_x(rHJX_R)*R_pelvis0*[0; 0; 1];

    ksi_thighR_x=ksi_pelvis_z+[cross(pos_HJR,u_thighR_x); u_thighR_x]*drHJX_R;
    ksi_thighR_y=ksi_thighR_x+[cross(pos_HJR,u_thighR_y); u_thighR_y]*drHJY_R;
    ksi_thighR_z=ksi_thighR_y+[cross(pos_HJR,u_thighR_z); u_thighR_z]*drHJZ_R;

    dksi_thighR_x=dksi_pelvis_z+ksi_cross(ksi_thighR_x)*[cross(pos_HJR,u_thighR_x); u_thighR_x]*drHJX_R+[cross(pos_HJR,u_thighR_x); u_thighR_x]*ddrHJX_R;
    dksi_thighR_y=dksi_thighR_x+ksi_cross(ksi_thighR_y)*[cross(pos_HJR,u_thighR_y); u_thighR_y]*drHJY_R+[cross(pos_HJR,u_thighR_y); u_thighR_y]*ddrHJY_R;
    dksi_thighR_z=dksi_thighR_y+ksi_cross(ksi_thighR_z)*[cross(pos_HJR,u_thighR_z); u_thighR_z]*drHJZ_R+[cross(pos_HJR,u_thighR_z); u_thighR_z]*ddrHJZ_R;

    
    % thighR to shankR
    R_shankR0=rot_z(rKJZ_R)*R_thighR0;
    pos_KJR=pos_HJR+R_thighR0*d_HJR_KJR;
    
    u_shankR_z=R_thighR0*[0; 0; 1];

    ksi_shankR_z=ksi_thighR_z+[cross(pos_KJR,u_shankR_z); u_shankR_z]*drKJZ_R;

    dksi_shankR_z=dksi_thighR_z+ksi_cross(ksi_shankR_z)*[cross(pos_KJR,u_shankR_z); u_shankR_z]*drKJZ_R+[cross(pos_KJR,u_shankR_z); u_shankR_z]*ddrKJZ_R;

    
    % shankR to footR
    R_footR0=rot_z(rAJZ_R)*rot_y(rAJY_R)*rot_x(rAJX_R)*R_shankR0;
    pos_AJR=pos_KJR+R_shankR0*d_KJR_AJR;

    u_footR_x=R_shankR0*[1; 0; 0];
    u_footR_y=rot_x(rAJX_R)*R_shankR0*[0; 1; 0];
    u_footR_z=rot_y(rAJY_R)*rot_x(rAJX_R)*R_shankR0*[0; 0; 1];

    ksi_footR_x=ksi_shankR_z+[cross(pos_AJR,u_footR_x); u_footR_x]*drAJX_R;
    ksi_footR_y=ksi_footR_x+[cross(pos_AJR,u_footR_y); u_footR_y]*drAJY_R;
    ksi_footR_z=ksi_footR_y+[cross(pos_AJR,u_footR_z); u_footR_z]*drAJZ_R;

    dksi_footR_x=dksi_shankR_z+ksi_cross(ksi_footR_x)*[cross(pos_AJR,u_footR_x); u_footR_x]*drAJX_R+[cross(pos_AJR,u_footR_x); u_footR_x]*ddrAJX_R;
    dksi_footR_y=dksi_footR_x+ksi_cross(ksi_footR_y)*[cross(pos_AJR,u_footR_y); u_footR_y]*drAJY_R+[cross(pos_AJR,u_footR_y); u_footR_y]*ddrAJY_R;
    dksi_footR_z=dksi_footR_y+ksi_cross(ksi_footR_z)*[cross(pos_AJR,u_footR_z); u_footR_z]*drAJZ_R+[cross(pos_AJR,u_footR_z); u_footR_z]*ddrAJZ_R;
    
    

%% from nb to 1 : effort
   
    % lowerArmL
    c_lowerArmL=pos_EJL+R_lowerArmL0*d_lowerArmL_EJL_c; %center of mass lowerArmL

    Is_lowerArmL=Is_construct(c_lowerArmL,m_lowerArmL,I_lowerArmL); % spatial inertia matrix
    
    facc_lowerArmL_z=Is_lowerArmL*dksi_lowerArmL_z+ksi_cross(ksi_lowerArmL_z)*(Is_lowerArmL*ksi_lowerArmL_z); % net forces (linked to the acceleration)
   
    fi_lowerArmL_z=facc_lowerArmL_z-[m_lowerArmL*g;cross(c_lowerArmL,m_lowerArmL*g)]; %reaction efforts.
    
    
    % upperArmL
    c_upperArmL=pos_SJL+R_upperArmL0*d_upperArmL_SJL_c; %center of mass upperArmL

    Is_upperArmL=Is_construct(c_upperArmL,m_upperArmL,I_upperArmL);
    
    facc_upperArmL_z=Is_upperArmL*dksi_upperArmL_z+ksi_cross(ksi_upperArmL_z)*(Is_upperArmL*ksi_upperArmL_z);
   
    fi_upperArmL_z=facc_upperArmL_z-[m_upperArmL*g;cross(c_upperArmL,m_upperArmL*g)]+fi_lowerArmL_z;
    fi_upperArmL_y=fi_upperArmL_z;
    fi_upperArmL_x=fi_upperArmL_y;
    
    
    % lowerArmR
    c_lowerArmR=pos_EJR+R_lowerArmR0*d_lowerArmR_EJR_c; %center of mass lowerArmR

    Is_lowerArmR=Is_construct(c_lowerArmR,m_lowerArmR,I_lowerArmR);
    
    facc_lowerArmR_z=Is_lowerArmR*dksi_lowerArmR_z+ksi_cross(ksi_lowerArmR_z)*(Is_lowerArmR*ksi_lowerArmR_z);
   
    fi_lowerArmR_z=facc_lowerArmR_z-[m_lowerArmR*g;cross(c_lowerArmR,m_lowerArmR*g)];
    
    
    % upperArmR
    c_upperArmR=pos_SJR+R_upperArmR0*d_upperArmR_SJR_c; %center of mass upperArmR

    Is_upperArmR=Is_construct(c_upperArmR,m_upperArmR,I_upperArmR);
    
    facc_upperArmR_z=Is_upperArmR*dksi_upperArmR_z+ksi_cross(ksi_upperArmR_z)*(Is_upperArmR*ksi_upperArmR_z);
   
    fi_upperArmR_z=facc_upperArmR_z-[m_upperArmR*g;cross(c_upperArmR,m_upperArmR*g)]+fi_lowerArmR_z;
    fi_upperArmR_y=fi_upperArmR_z;
    fi_upperArmR_x=fi_upperArmR_y;
    
    
    %head
    c_head=pos_LNJ+R_head0*d_head_LNJ_c; %center of mass head

    Is_head=Is_construct(c_head,m_head,I_head);
    
    facc_head_z=Is_head*dksi_head_z+ksi_cross(ksi_head_z)*(Is_head*ksi_head_z);
   
    fi_head_z=facc_head_z-[m_head*g;cross(c_head,m_head*g)];
    fi_head_y=fi_head_z;
    fi_head_x=fi_head_y;
    
    %thorax
    c_thorax=pos_LNJ+R_thorax0*d_thorax_LNJ_c; %center of mass thorax

    Is_thorax=Is_construct(c_thorax,m_thorax,I_thorax);
    
    facc_thorax_z=Is_thorax*dksi_thorax_z+ksi_cross(ksi_thorax_z)*(Is_thorax*ksi_thorax_z);
   
    fi_thorax_z=facc_thorax_z-[m_thorax*g;cross(c_thorax,m_thorax*g)]+fi_head_x+fi_upperArmR_x+fi_upperArmL_x;
    fi_thorax_y=fi_thorax_z;
    fi_thorax_x=fi_thorax_y;
    
    % abdomen 
    c_abdomen=pos_ULJ+R_abdomen0*d_abdomen_ULJ_c; %center of mass abdomen

    Is_abdomen=Is_construct(c_abdomen,m_abdomen,I_abdomen);
    
    facc_abdomen_z=Is_abdomen*dksi_abdomen_z+ksi_cross(ksi_abdomen_z)*(Is_abdomen*ksi_abdomen_z);
   
    fi_abdomen_z=facc_abdomen_z-[m_abdomen*g;cross(c_abdomen,m_abdomen*g)]+fi_thorax_x;
    fi_abdomen_x=fi_abdomen_z;
    
    % footL
    c_footL=pos_AJL+R_footL0*d_footL_AJL_c; %center of mass footL

    Is_footL=Is_construct(c_footL,m_footL,I_footL);
    
    facc_footL_z=Is_footL*dksi_footL_z+ksi_cross(ksi_footL_z)*(Is_footL*ksi_footL_z);
    
    % Conversion NaN values of center of pressure to zero
    if (isnan(force.grfX_L(i))||isnan(force.grfY_L(i))||isnan(force.grfZ_L(i))||isnan(force.copX_L(i))||isnan(force.copY_L(i))||isnan(force.copZ_L(i)))
        freactL=zeros(3,1);pos_reactL=ones(3,1);
    else
        freactL=[force.grfX_L(i);force.grfY_L(i);force.grfZ_L(i)];
        pos_reactL=[force.copX_L(i);force.copY_L(i);force.copZ_L(i)]*1e-3;
    end



    fi_footL_z=facc_footL_z-[m_footL*g;cross(c_footL,m_footL*g)]-[freactL;cross(pos_reactL,freactL)];
    fi_footL_y=fi_footL_z;
    fi_footL_x=fi_footL_y;
    
    
    % shankL
    c_shankL=pos_KJL+R_shankL0*d_shankL_KJL_c; %center of mass of shankL

    Is_shankL=Is_construct(c_shankL,m_shankL,I_shankL);
    
    facc_shankL_z=Is_shankL*dksi_shankL_z+ksi_cross(ksi_shankL_z)*(Is_shankL*ksi_shankL_z);
   
    fi_shankL_z=facc_shankL_z-[m_shankL*g;cross(c_shankL,m_shankL*g)]+fi_footL_x;
    
    
    % thighL
    c_thighL=pos_HJL+R_thighL0*d_thighL_HJL_c; %center of mass of thighL

    Is_thighL=Is_construct(c_thighL,m_thighL,I_thighL);
    
    facc_thighL_z=Is_thighL*dksi_thighL_z+ksi_cross(ksi_thighL_z)*(Is_thighL*ksi_thighL_z);
   
    fi_thighL_z=facc_thighL_z-[m_thighL*g;cross(c_thighL,m_thighL*g)]+fi_shankL_z;
    fi_thighL_y=fi_thighL_z;
    fi_thighL_x=fi_thighL_y;
    
    
    % footR
    c_footR=pos_AJR+R_footR0*d_footR_AJR_c; %center of mass of footR

    Is_footR=Is_construct(c_footR,m_footR,I_footR);
    
    facc_footR_z=Is_footR*dksi_footR_z+ksi_cross(ksi_footR_z)*(Is_footR*ksi_footR_z);
   
    % Conversion of NaN values of centes of pressure to zero
    if (isnan(force.grfX_R(i))||isnan(force.grfY_R(i))||isnan(force.grfZ_R(i))||isnan(force.copX_R(i))||isnan(force.copY_R(i))||isnan(force.copZ_R(i)))
        freactR=zeros(3,1);pos_reactR=ones(3,1);
    else
        freactR=[force.grfX_R(i);force.grfY_R(i);force.grfZ_R(i)];
        pos_reactR=[force.copX_R(i);force.copY_R(i);force.copZ_R(i)]*1e-3;
    end
    
    fi_footR_z=facc_footR_z-[m_footR*g;cross(c_footR,m_footR*g)]-[freactR;cross(pos_reactR,freactR)];
    fi_footR_y=fi_footR_z;
    fi_footR_x=fi_footR_y;
    
    
    % shankR
    c_shankR=pos_KJR+R_shankR0*d_shankR_KJR_c; %center of mass of shankR

    Is_shankR=Is_construct(c_shankR,m_shankR,I_shankR);
    
    facc_shankR_z=Is_shankR*dksi_shankR_z+ksi_cross(ksi_shankR_z)*(Is_shankR*ksi_shankR_z);
   
    fi_shankR_z=facc_shankR_z-[m_shankR*g;cross(c_shankR,m_shankR*g)]+fi_footR_x;
    
    
    % thighR
    c_thighR=pos_HJR+R_thighR0*d_thighR_HJR_c; %center of mass of thighR 

    Is_thighR=Is_construct(c_thighR,m_thighR,I_thighR);
    
    facc_thighR_z=Is_thighR*dksi_thighR_z+ksi_cross(ksi_thighR_z)*(Is_thighR*ksi_thighR_z);
   
    fi_thighR_z=facc_thighR_z-[m_thighR*g;cross(c_thighR,m_thighR*g)]+fi_shankR_z;
    fi_thighR_y=fi_thighR_z;
    fi_thighR_x=fi_thighR_y;
    
        
    % pelvis
    c_pelvis=pos_LLJ+R_pelvis0*d_pelvis_LLJ_c; %center of mass pelvis

    Is_pelvis=Is_construct(c_pelvis,m_pelvis,I_pelvis);
    
    facc_pelvis_z=Is_pelvis*dksi_pelvis_z+ksi_cross(ksi_pelvis_z)*(Is_pelvis*ksi_pelvis_z);
   
    fi_pelvis_z=facc_pelvis_z-[m_pelvis*g;cross(c_pelvis,m_pelvis*g)]+fi_thighR_x+fi_thighL_x+fi_abdomen_x;
    fi_pelvis_y=fi_pelvis_z;
    fi_pelvis_x=fi_pelvis_y;
    
    
%% Torques
    T_KJZ_L(k)=transpose([cross(pos_KJL,u_shankL_z); u_shankL_z])*fi_shankL_z;
    T_KJZ_R(k)=transpose([cross(pos_KJR,u_shankR_z); u_shankR_z])*fi_shankR_z;
    
    T_HJZ_L(k)=transpose([cross(pos_HJL,u_thighL_z); u_thighL_z])*fi_thighL_z;
    T_HJZ_R(k)=transpose([cross(pos_HJR,u_thighR_z); u_thighR_z])*fi_thighR_z;
    T_HJY_L(k)=transpose([cross(pos_HJL,u_thighL_y); u_thighL_y])*fi_thighL_y;
    T_HJY_R(k)=transpose([cross(pos_HJR,u_thighR_y); u_thighR_y])*fi_thighR_y;
    T_HJX_L(k)=transpose([cross(pos_HJL,u_thighL_x); u_thighL_x])*fi_thighL_x;
    T_HJX_R(k)=transpose([cross(pos_HJR,u_thighR_x); u_thighR_x])*fi_thighR_x;
    
    T_AJZ_L(k)=transpose([cross(pos_AJL,u_footL_z); u_footL_z])*fi_footL_z;
    T_AJZ_R(k)=transpose([cross(pos_AJR,u_footR_z); u_footR_z])*fi_footR_z;
    T_AJY_L(k)=transpose([cross(pos_AJL,u_footL_y); u_footL_y])*fi_footL_y;
    T_AJY_R(k)=transpose([cross(pos_AJR,u_footR_y); u_footR_y])*fi_footR_y;
    T_AJX_L(k)=transpose([cross(pos_AJL,u_footL_x); u_footL_x])*fi_footL_x;
    T_AJX_R(k)=transpose([cross(pos_AJR,u_footR_x); u_footR_x])*fi_footR_x;

    T_BJZ(k)=transpose([cross(pos_LLJ,u_pelvis_z); u_pelvis_z])*fi_pelvis_z;
    T_BJY(k)=transpose([cross(pos_LLJ,u_pelvis_y); u_pelvis_y])*fi_pelvis_y;
    T_BJX(k)=transpose([cross(pos_LLJ,u_pelvis_x); u_pelvis_x])*fi_pelvis_x;
    F_BJZ(k)=fi_pelvis_x(3);
    F_BJY(k)=fi_pelvis_x(2);
    F_BJX(k)=fi_pelvis_x(1);
    
    T_LNJZ(k)=transpose([cross(pos_LNJ,u_head_z); u_head_z])*fi_head_z;
    T_LNJY(k)=transpose([cross(pos_LNJ,u_head_y); u_head_y])*fi_head_y;
    T_LNJX(k)=transpose([cross(pos_LNJ,u_head_x); u_head_x])*fi_head_x;
    
    T_SJZ_L(k)=transpose([cross(pos_SJL,u_upperArmL_z); u_upperArmL_z])*fi_upperArmL_z;
    T_SJY_L(k)=transpose([cross(pos_SJL,u_upperArmL_y); u_upperArmL_y])*fi_upperArmL_y;
    T_SJX_L(k)=transpose([cross(pos_SJL,u_upperArmL_x); u_upperArmL_x])*fi_upperArmL_x;
    
    T_SJZ_R(k)=transpose([cross(pos_SJR,u_upperArmR_z); u_upperArmR_z])*fi_upperArmR_z;
    T_SJY_R(k)=transpose([cross(pos_SJR,u_upperArmR_y); u_upperArmR_y])*fi_upperArmR_y;
    T_SJX_R(k)=transpose([cross(pos_SJR,u_upperArmR_x); u_upperArmR_x])*fi_upperArmR_x;
    
    T_EJZ_L(k)=transpose([cross(pos_EJL,u_lowerArmL_z); u_lowerArmL_z])*fi_lowerArmL_z;
    T_EJZ_R(k)=transpose([cross(pos_EJR,u_lowerArmR_z); u_lowerArmR_z])*fi_lowerArmR_z;
    
    T_ULJZ(k)=transpose([cross(pos_ULJ,u_thorax_z); u_thorax_z])*fi_thorax_z;
    T_ULJY(k)=transpose([cross(pos_ULJ,u_thorax_y); u_thorax_y])*fi_thorax_y;
    T_ULJX(k)=transpose([cross(pos_ULJ,u_thorax_x); u_thorax_x])*fi_thorax_x;
    
    T_LLJZ(k)=transpose([cross(pos_LLJ,u_abdomen_z); u_abdomen_z])*fi_abdomen_z;
    T_LLJX(k)=transpose([cross(pos_LLJ,u_abdomen_x); u_abdomen_x])*fi_abdomen_x;
end

Torques(23:36,:)=[T_HJX_L; T_HJY_L; T_HJZ_L; T_HJX_R; T_HJY_R; T_HJZ_R; T_KJZ_L; T_KJZ_R; T_AJX_L; T_AJY_L; T_AJZ_L; T_AJX_R; T_AJY_R; T_AJZ_R];
Torques(1:6,:)=[F_BJX; F_BJY; F_BJZ; T_BJX; T_BJY; T_BJZ];
Torques(7:22,:)=[T_LNJX; T_LNJY; T_LNJZ; T_SJX_L; T_SJY_L; T_SJZ_L; T_SJX_R; T_SJY_R; T_SJZ_R; T_EJZ_L; T_EJZ_R; T_ULJX; T_ULJY; T_ULJZ; T_LLJX; T_LLJZ];
save (strcat('raw_torques_',Motion,".mat"), 'Torques'); 
clear -regexp L ^F_ ^T_ ^ksi ^pos ^fi ^facc ^c_ ^Is_ ^I_ ^R_ ^psi ^u_ ^m_ ^d_ ksi_ ^dp ^dr ^ddp ^ddr pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R
