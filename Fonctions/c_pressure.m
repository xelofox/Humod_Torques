function cpLR= c_pressure(q)
%load(file);
%load('c_footL.mat');
%load('c_footR.mat');
%load('R_footL0.mat')
%load('R_footR0.mat')


centerR=[force.copX_R; force.copY_R; force.copZ_R];
centerL=[force.copX_L; force.copY_L; force.copZ_L];
cpLR=zeros(2,3);
%q=motion.trajectory.q(i,:);

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