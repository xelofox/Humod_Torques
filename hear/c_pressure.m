function cpLR= c_pressure(k,force,motion,c_footL,c_footR,R_footL0,R_footR0)
%load(file);
%load('c_footL.mat');
%load('c_footR.mat');
%load('R_footL0.mat')
%load('R_footR0.mat')

syms pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R real;
syms dpBJX dpBJY dpBJZ drBJX drBJY drBJZ drLNJX drLNJY drLNJZ drSJX_L drSJY_L drSJZ_L drSJX_R drSJY_R drSJZ_R drEJZ_L drEJZ_R drULJX drULJY drULJZ drLLJX drLLJZ drHJX_L drHJY_L drHJZ_L drHJX_R drHJY_R drHJZ_R drKJZ_L drKJZ_R drAJX_L drAJY_L drAJZ_L drAJX_R drAJY_R drAJZ_R real;
syms ddpBJX ddpBJY ddpBJZ ddrBJX ddrBJY ddrBJZ ddrLNJX ddrLNJY ddrLNJZ ddrSJX_L ddrSJY_L ddrSJZ_L ddrSJX_R ddrSJY_R ddrSJZ_R ddrEJZ_L ddrEJZ_R ddrULJX ddrULJY ddrULJZ ddrLLJX ddrLLJZ ddrHJX_L ddrHJY_L ddrHJZ_L ddrHJX_R ddrHJY_R ddrHJZ_R ddrKJZ_L ddrKJZ_R ddrAJX_L ddrAJY_L ddrAJZ_L ddrAJX_R ddrAJY_R ddrAJZ_R real;

centerR=[force.copX_R(k); force.copY_R(k); force.copZ_R(k)];
centerL=[force.copX_L(k); force.copY_L(k); force.copZ_L(k)];
cpLR=zeros(2,3);
q=transpose(motion.trajectory.q(:,k));

iR=centerR-subs(c_footR,[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R],q);
iL=centerL-subs(c_footL,[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R],q);
Rot_R=subs(R_footR0,[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R],q);
Rot_L=subs(R_footL0,[pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R],q);
Rot_R=inv(Rot_R);
Rot_L=inv(Rot_L);
iR=Rot_R*iR;
iL=Rot_L*iL;

cpLR(2,:)=transpose(iR);
cpLR(1,:)=transpose(iL);
end