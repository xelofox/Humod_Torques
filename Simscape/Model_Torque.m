clear all;
close all;
clc;

%% ------------Load .slx models----------

load_system('TorqueMdl');

%% ------------Initial configuration----------

load Parameters.mat;
% load 1.1.mat; filename = "1.1.mat"; % Straight walking 1 m/s
load 1.2.mat; filename = "1.2.mat"; % Straight walking 1.5 m/s
% load 1.3.mat; filename = "1.3.mat"; % Straight walking 2 m/s
% load 2.1.mat; filename = "2.1.mat"; % Straight running 2 m/s
% load 2.2.mat; filename = "2.2.mat"; % Straight running 3 m/s
% load 2.3.mat; filename = "2.3.mat"; % Straight running 4 m/s
% load 3.mat; filename = "3.mat"; % Sideways walking 5 m/s
% load 4.mat; filename = "4.mat"; % Transition 0 to 4 m/s
% load 5.1.mat; filename = "5.1.mat"; % Avoiding a long box obstacle
% load 5.2.mat; filename = "5.2.mat"; % Avoiding a wide box obstacle
% load 6.mat; filename = "6.mat"; %Squats
% load 7.mat; filename = "7.mat"; % Kicks
% load 8.mat; filename = "8.mat"; % Jumps

Rep_size = 5;
N=motion.frames;

set_param('TorqueMdl/Head', 'BrickDimensions', '[Rep_size head.segmentLengthY Rep_size]');
set_param('TorqueMdl/Head', 'InertiaType', 'Custom');
set_param('TorqueMdl/Head', 'Mass', 'head.mass');
set_param('TorqueMdl/Head', 'MassUnits', 'kg');
set_param('TorqueMdl/Head', 'CenterOfMass', '[head.comX (head.comY - (head.segmentLengthY/2)) head.comZ]' );
set_param('TorqueMdl/Head', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Head', 'MomentsOfInertia', '[head.moiXX head.moiYY head.moiZZ]' );
set_param('TorqueMdl/Head', 'ProductsOfInertia', '[head.poiXY head.poiXZ head.poiYZ]' );

set_param('TorqueMdl/Thorax', 'BrickDimensions', '[Rep_size thorax.segmentLengthY Rep_size]');
set_param('TorqueMdl/Thorax', 'InertiaType', 'Custom');
set_param('TorqueMdl/Thorax', 'Mass', 'thorax.mass');
set_param('TorqueMdl/Thorax', 'MassUnits', 'kg');
set_param('TorqueMdl/Thorax', 'CenterOfMass', '[thorax.comX (thorax.comY + (thorax.segmentLengthY/2)) thorax.comZ]' );
set_param('TorqueMdl/Thorax', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Thorax', 'MomentsOfInertia', '[thorax.moiXX thorax.moiYY thorax.moiZZ]' );
set_param('TorqueMdl/Thorax', 'ProductsOfInertia', '[thorax.poiXY thorax.poiXZ thorax.poiYZ]' );

set_param('TorqueMdl/Thorax_R', 'BrickDimensions', '[abs(thorax.relativePosition.SJ_R(1)) abs(thorax.relativePosition.SJ_R(2)) abs(thorax.relativePosition.SJ_R(3))]');
set_param('TorqueMdl/Thorax_L', 'BrickDimensions', '[abs(thorax.relativePosition.SJ_L(1)) abs(thorax.relativePosition.SJ_L(2)) abs(thorax.relativePosition.SJ_L(3))]');

set_param('TorqueMdl/Abdomen', 'BrickDimensions', '[Rep_size abdomen.segmentLengthY Rep_size]');
set_param('TorqueMdl/Abdomen', 'InertiaType', 'Custom');
set_param('TorqueMdl/Abdomen', 'Mass', 'abdomen.mass');
set_param('TorqueMdl/Abdomen', 'MassUnits', 'kg');
set_param('TorqueMdl/Abdomen', 'CenterOfMass', '[abdomen.comX (abdomen.comY + (abdomen.segmentLengthY/2)) abdomen.comZ]' );
set_param('TorqueMdl/Abdomen', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Abdomen', 'MomentsOfInertia', '[abdomen.moiXX abdomen.moiYY abdomen.moiZZ]' );
set_param('TorqueMdl/Abdomen', 'ProductsOfInertia', '[abdomen.poiXY abdomen.poiXZ abdomen.poiYZ]' );

set_param('TorqueMdl/Pelvis', 'BrickDimensions', '[Rep_size pelvis.segmentLengthY pelvis.segmentLengthZ]');
set_param('TorqueMdl/Pelvis', 'InertiaType', 'Custom');
set_param('TorqueMdl/Pelvis', 'Mass', 'pelvis.mass');
set_param('TorqueMdl/Pelvis', 'MassUnits', 'kg');
set_param('TorqueMdl/Pelvis', 'CenterOfMass', '[pelvis.comX (pelvis.comY + (pelvis.segmentLengthY/2)) pelvis.comZ]' );
set_param('TorqueMdl/Pelvis', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Pelvis', 'MomentsOfInertia', '[pelvis.moiXX pelvis.moiYY pelvis.moiZZ]' );
set_param('TorqueMdl/Pelvis', 'ProductsOfInertia', '[pelvis.poiXY pelvis.poiXZ pelvis.poiYZ]' );

set_param('TorqueMdl/Pelvis_R', 'BrickDimensions', '[abs(pelvis.relativePosition.HJ_R(1)) abs(pelvis.relativePosition.HJ_R(2)) abs(pelvis.relativePosition.HJ_R(3))]');
set_param('TorqueMdl/Pelvis_L', 'BrickDimensions', '[abs(pelvis.relativePosition.HJ_L(1)) abs(pelvis.relativePosition.HJ_L(2)) abs(pelvis.relativePosition.HJ_L(3))]');

set_param('TorqueMdl/Thigh_R', 'BrickDimensions', '[Rep_size thigh_R.segmentLengthY Rep_size]');
set_param('TorqueMdl/Thigh_R', 'InertiaType', 'Custom');
set_param('TorqueMdl/Thigh_R', 'Mass', 'thigh_R.mass');
set_param('TorqueMdl/Thigh_R', 'MassUnits', 'kg');
set_param('TorqueMdl/Thigh_R', 'CenterOfMass', '[thigh_R.comX (thigh_R.comY + (thigh_R.segmentLengthY/2)) thigh_R.comZ]' );
set_param('TorqueMdl/Thigh_R', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Thigh_R', 'MomentsOfInertia', '[thigh_R.moiXX thigh_R.moiYY thigh_R.moiZZ]' );
set_param('TorqueMdl/Thigh_R', 'ProductsOfInertia', '[thigh_R.poiXY thigh_R.poiXZ thigh_R.poiYZ]' );

set_param('TorqueMdl/Shank_R', 'BrickDimensions', '[Rep_size shank_R.segmentLengthY Rep_size]');
set_param('TorqueMdl/Shank_R', 'InertiaType', 'Custom');
set_param('TorqueMdl/Shank_R', 'Mass', 'shank_R.mass');
set_param('TorqueMdl/Shank_R', 'MassUnits', 'kg');
set_param('TorqueMdl/Shank_R', 'CenterOfMass', '[shank_R.comX (shank_R.comY + (shank_R.segmentLengthY/2)) shank_R.comZ]' );
set_param('TorqueMdl/Shank_R', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Shank_R', 'MomentsOfInertia', '[shank_R.moiXX shank_R.moiYY shank_R.moiZZ]' );
set_param('TorqueMdl/Shank_R', 'ProductsOfInertia', '[shank_R.poiXY shank_R.poiXZ shank_R.poiYZ]' );

set_param('TorqueMdl/Foot_R', 'BrickDimensions', '[foot_R.segmentLengthX foot_R.segmentLengthY foot_R.segmentLengthZ]');
set_param('TorqueMdl/Foot_R', 'InertiaType', 'Custom');
set_param('TorqueMdl/Foot_R', 'Mass', 'foot_R.mass');
set_param('TorqueMdl/Foot_R', 'MassUnits', 'kg');
set_param('TorqueMdl/Foot_R', 'CenterOfMass', '[(foot_R.comX - (foot_R.segmentLengthX/2)) (foot_R.comY + (foot_R.segmentLengthY/2)) (foot_R.comZ - (foot_R.segmentLengthZ/2))]' );
set_param('TorqueMdl/Foot_R', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Foot_R', 'MomentsOfInertia', '[foot_R.moiXX foot_R.moiYY foot_R.moiZZ]' );
set_param('TorqueMdl/Foot_R', 'ProductsOfInertia', '[foot_R.poiXY foot_R.poiXZ foot_R.poiYZ]' );

set_param('TorqueMdl/Thigh_L', 'BrickDimensions', '[Rep_size thigh_L.segmentLengthY Rep_size]');
set_param('TorqueMdl/Thigh_L', 'InertiaType', 'Custom');
set_param('TorqueMdl/Thigh_L', 'Mass', 'thigh_L.mass');
set_param('TorqueMdl/Thigh_L', 'MassUnits', 'kg');
set_param('TorqueMdl/Thigh_L', 'CenterOfMass', '[thigh_L.comX (thigh_L.comY + (thigh_L.segmentLengthY/2)) thigh_L.comZ]' );
set_param('TorqueMdl/Thigh_L', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Thigh_L', 'MomentsOfInertia', '[thigh_L.moiXX thigh_L.moiYY thigh_L.moiZZ]' );
set_param('TorqueMdl/Thigh_L', 'ProductsOfInertia', '[thigh_L.poiXY thigh_L.poiXZ thigh_L.poiYZ]' );

set_param('TorqueMdl/Shank_L', 'BrickDimensions', '[Rep_size shank_L.segmentLengthY Rep_size]');
set_param('TorqueMdl/Shank_L', 'InertiaType', 'Custom');
set_param('TorqueMdl/Shank_L', 'Mass', 'shank_L.mass');
set_param('TorqueMdl/Shank_L', 'MassUnits', 'kg');
set_param('TorqueMdl/Shank_L', 'CenterOfMass', '[shank_L.comX (shank_L.comY + (shank_L.segmentLengthY/2)) shank_L.comZ]' );
set_param('TorqueMdl/Shank_L', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Shank_L', 'MomentsOfInertia', '[shank_L.moiXX shank_L.moiYY shank_L.moiZZ]' );
set_param('TorqueMdl/Shank_L', 'ProductsOfInertia', '[shank_L.poiXY shank_L.poiXZ shank_L.poiYZ]' );

set_param('TorqueMdl/Foot_L', 'BrickDimensions', '[foot_L.segmentLengthX foot_L.segmentLengthY foot_L.segmentLengthZ]');
set_param('TorqueMdl/Foot_L', 'InertiaType', 'Custom');
set_param('TorqueMdl/Foot_L', 'Mass', 'foot_L.mass');
set_param('TorqueMdl/Foot_L', 'MassUnits', 'kg');
set_param('TorqueMdl/Foot_L', 'CenterOfMass', '[(foot_L.comX - (foot_L.segmentLengthX/2)) (foot_L.comY + (foot_L.segmentLengthY/2)) (foot_L.comZ + (foot_L.segmentLengthZ/2))]' );
set_param('TorqueMdl/Foot_L', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/Foot_L', 'MomentsOfInertia', '[foot_L.moiXX foot_L.moiYY foot_L.moiZZ]' );
set_param('TorqueMdl/Foot_L', 'ProductsOfInertia', '[foot_L.poiXY foot_L.poiXZ foot_L.poiYZ]' );

set_param('TorqueMdl/UpperArm_R', 'BrickDimensions', '[Rep_size upperArm_R.segmentLengthY Rep_size]');
set_param('TorqueMdl/UpperArm_R', 'InertiaType', 'Custom');
set_param('TorqueMdl/UpperArm_R', 'Mass', 'upperArm_R.mass');
set_param('TorqueMdl/UpperArm_R', 'MassUnits', 'kg');
set_param('TorqueMdl/UpperArm_R', 'CenterOfMass', '[upperArm_R.comX (upperArm_R.comY + (upperArm_R.segmentLengthY/2)) upperArm_R.comZ]' );
set_param('TorqueMdl/UpperArm_R', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/UpperArm_R', 'MomentsOfInertia', '[upperArm_R.moiXX upperArm_R.moiYY upperArm_R.moiZZ]' );
set_param('TorqueMdl/UpperArm_R', 'ProductsOfInertia', '[upperArm_R.poiXY upperArm_R.poiXZ upperArm_R.poiYZ]' );

set_param('TorqueMdl/LowerArm_R', 'BrickDimensions', '[Rep_size lowerArm_R.segmentLengthY Rep_size]');
set_param('TorqueMdl/LowerArm_R', 'InertiaType', 'Custom');
set_param('TorqueMdl/LowerArm_R', 'Mass', 'lowerArm_R.mass');
set_param('TorqueMdl/LowerArm_R', 'MassUnits', 'kg');
set_param('TorqueMdl/LowerArm_R', 'CenterOfMass', '[lowerArm_R.comX (lowerArm_R.comY + (lowerArm_R.segmentLengthY/2)) lowerArm_R.comZ]' );
set_param('TorqueMdl/LowerArm_R', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/LowerArm_R', 'MomentsOfInertia', '[lowerArm_R.moiXX lowerArm_R.moiYY lowerArm_R.moiZZ]' );
set_param('TorqueMdl/LowerArm_R', 'ProductsOfInertia', '[lowerArm_R.poiXY lowerArm_R.poiXZ lowerArm_R.poiYZ]' );

set_param('TorqueMdl/UpperArm_L', 'BrickDimensions', '[Rep_size upperArm_L.segmentLengthY Rep_size]');
set_param('TorqueMdl/UpperArm_L', 'InertiaType', 'Custom');
set_param('TorqueMdl/UpperArm_L', 'Mass', 'upperArm_L.mass');
set_param('TorqueMdl/UpperArm_L', 'MassUnits', 'kg');
set_param('TorqueMdl/UpperArm_L', 'CenterOfMass', '[upperArm_L.comX (upperArm_L.comY + (upperArm_L.segmentLengthY/2)) upperArm_L.comZ]' );
set_param('TorqueMdl/UpperArm_L', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/UpperArm_L', 'MomentsOfInertia', '[upperArm_L.moiXX upperArm_L.moiYY upperArm_L.moiZZ]' );
set_param('TorqueMdl/UpperArm_L', 'ProductsOfInertia', '[upperArm_L.poiXY upperArm_L.poiXZ upperArm_L.poiYZ]' );

set_param('TorqueMdl/LowerArm_L', 'BrickDimensions', '[Rep_size lowerArm_L.segmentLengthY Rep_size]');
set_param('TorqueMdl/LowerArm_L', 'InertiaType', 'Custom');
set_param('TorqueMdl/LowerArm_L', 'Mass', 'lowerArm_L.mass');
set_param('TorqueMdl/LowerArm_L', 'MassUnits', 'kg');
set_param('TorqueMdl/LowerArm_L', 'CenterOfMass', '[lowerArm_L.comX (lowerArm_L.comY + (lowerArm_L.segmentLengthY/2)) lowerArm_L.comZ]' );
set_param('TorqueMdl/LowerArm_L', 'CenterOfMassUnits', 'mm' );
set_param('TorqueMdl/LowerArm_L', 'MomentsOfInertia', '[lowerArm_L.moiXX lowerArm_L.moiYY lowerArm_L.moiZZ]' );
set_param('TorqueMdl/LowerArm_L', 'ProductsOfInertia', '[lowerArm_L.poiXY lowerArm_L.poiXZ lowerArm_L.poiYZ]' );

%% ----------------Curve import---------------

time = 0:(1 / motion.frameRate):((motion.frames - 1) / motion.frameRate);
time = time';
for joint=1:length(motion.trajectoryLabels)
    Data = motion.trajectory.q(joint, :);
    Data = Data';
    timeseries(Data(:,1), time(:,1),'Name','q');
    save (char(motion.trajectoryLabels(joint)),'ans', '-v7.3');
end

for mvt=12:length(motion.jointLabels.smoothed)
    Data = motion.jointX.smoothed(mvt, :);
    Data = Data';
    timeseries(Data(:,1), time(:,1),'Name','Xtrajectory');
    save (strcat(char(motion.jointLabels.smoothed(mvt)), 'X') ,'ans', '-v7.3');
    
    Data = motion.jointY.smoothed(mvt, :);
    Data = Data';
    timeseries(Data(:,1), time(:,1),'Name','Ytrajectory');
    save (strcat(char(motion.jointLabels.smoothed(mvt)), 'Y') ,'ans', '-v7.3');
    
    Data = motion.jointZ.smoothed(mvt, :);
    Data = Data';
    timeseries(Data(:,1), time(:,1),'Name','Ztrajectory');
    save (strcat(char(motion.jointLabels.smoothed(mvt)), 'Z') ,'ans', '-v7.3');
end

time = 0:(1 / motion.frameRate):((motion.frames - 1) / motion.frameRate);
time = time';

Data = force.grfX_R;
Data = Data';
Data =Data(1:2:length(Data));
timeseries(Data(:,1), time(:,1),'Name','force');
save ('grfX_R','ans', '-v7.3');
Data = force.grfX_L;
Data = Data';
Data =Data(1:2:length(Data));
timeseries(Data(:,1), time(:,1),'Name','force');
save ('grfX_L','ans', '-v7.3');
Data = force.grfY_R;
Data = Data';
Data =Data(1:2:length(Data));
timeseries(Data(:,1), time(:,1),'Name','force');
save ('grfY_R','ans', '-v7.3');
Data = force.grfY_L;
Data = Data';
Data =Data(1:2:length(Data));
timeseries(Data(:,1), time(:,1),'Name','force');
save ('grfY_L','ans', '-v7.3');
Data = force.grfZ_R;
Data = Data';
Data =Data(1:2:length(Data));
timeseries(Data(:,1), time(:,1),'Name','force');
save ('grfZ_R','ans', '-v7.3');
Data = force.grfZ_L;
Data = Data';
Data =Data(1:2:length(Data));
timeseries(Data(:,1), time(:,1),'Name','force');
save ('grfZ_L','ans', '-v7.3');

%% ------------Cop computation----------

q=motion.trajectory.q;

CPR=zeros(3,length(q));
CPL=zeros(3,length(q));
time = 0:(1 / motion.frameRate):((motion.frames - 1) / motion.frameRate);
time = time';

for k=1:length(q)
    t=num2cell(transpose([q(:,k)]));
    [pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R]=deal(t{:});
    
    R_footR0=[ - (cos(rAJX_R)*sin(rAJZ_R) - cos(rAJZ_R)*sin(rAJX_R)*sin(rAJY_R))*(cos(rKJZ_R)*(sin(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*sin(rHJZ_R)) - sin(rKJZ_R)*(sin(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*cos(rHJZ_R))) - (sin(rAJX_R)*sin(rAJZ_R) + cos(rAJX_R)*cos(rAJZ_R)*sin(rAJY_R))*(cos(rBJY)*cos(rBJZ)*sin(rHJY_R) + cos(rHJX_R)*cos(rHJY_R)*sin(rBJY) - cos(rBJY)*cos(rHJY_R)*sin(rBJZ)*sin(rHJX_R)) - cos(rAJY_R)*cos(rAJZ_R)*(cos(rKJZ_R)*(sin(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*cos(rHJZ_R)) + sin(rKJZ_R)*(sin(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*sin(rHJZ_R))),   (sin(rAJX_R)*sin(rAJZ_R) + cos(rAJX_R)*cos(rAJZ_R)*sin(rAJY_R))*(sin(rHJY_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) + cos(rHJY_R)*sin(rHJX_R)*(cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ)) + cos(rBJY)*cos(rHJX_R)*cos(rHJY_R)*sin(rBJX)) + (cos(rAJX_R)*sin(rAJZ_R) - cos(rAJZ_R)*sin(rAJX_R)*sin(rAJY_R))*(cos(rKJZ_R)*(cos(rHJY_R)*sin(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R))) + sin(rKJZ_R)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)))) - cos(rAJY_R)*cos(rAJZ_R)*(cos(rKJZ_R)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))) - sin(rKJZ_R)*(cos(rHJY_R)*sin(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)))), cos(rAJY_R)*cos(rAJZ_R)*(sin(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) - cos(rHJY_R)*sin(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))) + cos(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)))) - (sin(rAJX_R)*sin(rAJZ_R) + cos(rAJX_R)*cos(rAJZ_R)*sin(rAJY_R))*(sin(rHJY_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rHJY_R)*sin(rHJX_R)*(cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ)) - cos(rBJX)*cos(rBJY)*cos(rHJX_R)*cos(rHJY_R)) - (sin(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))) - cos(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) - cos(rHJY_R)*sin(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))))*(cos(rAJX_R)*sin(rAJZ_R) - cos(rAJZ_R)*sin(rAJX_R)*sin(rAJY_R));
       (cos(rAJX_R)*cos(rAJZ_R) + sin(rAJX_R)*sin(rAJY_R)*sin(rAJZ_R))*(cos(rKJZ_R)*(sin(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*sin(rHJZ_R)) - sin(rKJZ_R)*(sin(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*cos(rHJZ_R))) + (cos(rAJZ_R)*sin(rAJX_R) - cos(rAJX_R)*sin(rAJY_R)*sin(rAJZ_R))*(cos(rBJY)*cos(rBJZ)*sin(rHJY_R) + cos(rHJX_R)*cos(rHJY_R)*sin(rBJY) - cos(rBJY)*cos(rHJY_R)*sin(rBJZ)*sin(rHJX_R)) - cos(rAJY_R)*sin(rAJZ_R)*(cos(rKJZ_R)*(sin(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*cos(rHJZ_R)) + sin(rKJZ_R)*(sin(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*sin(rHJZ_R))), - (cos(rAJZ_R)*sin(rAJX_R) - cos(rAJX_R)*sin(rAJY_R)*sin(rAJZ_R))*(sin(rHJY_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) + cos(rHJY_R)*sin(rHJX_R)*(cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ)) + cos(rBJY)*cos(rHJX_R)*cos(rHJY_R)*sin(rBJX)) - (cos(rAJX_R)*cos(rAJZ_R) + sin(rAJX_R)*sin(rAJY_R)*sin(rAJZ_R))*(cos(rKJZ_R)*(cos(rHJY_R)*sin(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R))) + sin(rKJZ_R)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)))) - cos(rAJY_R)*sin(rAJZ_R)*(cos(rKJZ_R)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))) - sin(rKJZ_R)*(cos(rHJY_R)*sin(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)))), (sin(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))) - cos(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) - cos(rHJY_R)*sin(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))))*(cos(rAJX_R)*cos(rAJZ_R) + sin(rAJX_R)*sin(rAJY_R)*sin(rAJZ_R)) + (cos(rAJZ_R)*sin(rAJX_R) - cos(rAJX_R)*sin(rAJY_R)*sin(rAJZ_R))*(sin(rHJY_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rHJY_R)*sin(rHJX_R)*(cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ)) - cos(rBJX)*cos(rBJY)*cos(rHJX_R)*cos(rHJY_R)) + cos(rAJY_R)*sin(rAJZ_R)*(sin(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) - cos(rHJY_R)*sin(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))) + cos(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))));
                                                                                                   sin(rAJY_R)*(cos(rKJZ_R)*(sin(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*cos(rHJZ_R)) + sin(rKJZ_R)*(sin(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*sin(rHJZ_R))) - cos(rAJX_R)*cos(rAJY_R)*(cos(rBJY)*cos(rBJZ)*sin(rHJY_R) + cos(rHJX_R)*cos(rHJY_R)*sin(rBJY) - cos(rBJY)*cos(rHJY_R)*sin(rBJZ)*sin(rHJX_R)) + cos(rAJY_R)*sin(rAJX_R)*(cos(rKJZ_R)*(sin(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*sin(rHJZ_R)) - sin(rKJZ_R)*(sin(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_R)*cos(rHJZ_R))),                                                                                               sin(rAJY_R)*(cos(rKJZ_R)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))) - sin(rKJZ_R)*(cos(rHJY_R)*sin(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)))) + cos(rAJX_R)*cos(rAJY_R)*(sin(rHJY_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) + cos(rHJY_R)*sin(rHJX_R)*(cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ)) + cos(rBJY)*cos(rHJX_R)*cos(rHJY_R)*sin(rBJX)) - cos(rAJY_R)*sin(rAJX_R)*(cos(rKJZ_R)*(cos(rHJY_R)*sin(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R))) + sin(rKJZ_R)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R)))),                                                                                             cos(rAJY_R)*sin(rAJX_R)*(sin(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))) - cos(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) - cos(rHJY_R)*sin(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)))) - cos(rAJX_R)*cos(rAJY_R)*(sin(rHJY_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rHJY_R)*sin(rHJX_R)*(cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ)) - cos(rBJX)*cos(rBJY)*cos(rHJX_R)*cos(rHJY_R)) - sin(rAJY_R)*(sin(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*cos(rHJZ_R) + sin(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_R)*sin(rHJX_R) - cos(rHJX_R)*sin(rHJY_R)*sin(rHJZ_R)) - cos(rHJY_R)*sin(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))) + cos(rKJZ_R)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_R)*sin(rHJZ_R) - cos(rHJZ_R)*sin(rHJX_R)*sin(rHJY_R)) + cos(rHJY_R)*cos(rHJZ_R)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_R)*sin(rHJZ_R) + cos(rHJX_R)*cos(rHJZ_R)*sin(rHJY_R))))];
 
    R_footL0=[ - (cos(rAJX_L)*sin(rAJZ_L) - cos(rAJZ_L)*sin(rAJX_L)*sin(rAJY_L))*(cos(rKJZ_L)*(sin(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*sin(rHJZ_L)) - sin(rKJZ_L)*(sin(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*cos(rHJZ_L))) - (sin(rAJX_L)*sin(rAJZ_L) + cos(rAJX_L)*cos(rAJZ_L)*sin(rAJY_L))*(cos(rBJY)*cos(rBJZ)*sin(rHJY_L) + cos(rHJX_L)*cos(rHJY_L)*sin(rBJY) - cos(rBJY)*cos(rHJY_L)*sin(rBJZ)*sin(rHJX_L)) - cos(rAJY_L)*cos(rAJZ_L)*(cos(rKJZ_L)*(sin(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*cos(rHJZ_L)) + sin(rKJZ_L)*(sin(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*sin(rHJZ_L))),   (sin(rAJX_L)*sin(rAJZ_L) + cos(rAJX_L)*cos(rAJZ_L)*sin(rAJY_L))*(sin(rHJY_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) + cos(rHJY_L)*sin(rHJX_L)*(cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ)) + cos(rBJY)*cos(rHJX_L)*cos(rHJY_L)*sin(rBJX)) + (cos(rAJX_L)*sin(rAJZ_L) - cos(rAJZ_L)*sin(rAJX_L)*sin(rAJY_L))*(cos(rKJZ_L)*(cos(rHJY_L)*sin(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L))) + sin(rKJZ_L)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)))) - cos(rAJY_L)*cos(rAJZ_L)*(cos(rKJZ_L)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))) - sin(rKJZ_L)*(cos(rHJY_L)*sin(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)))), cos(rAJY_L)*cos(rAJZ_L)*(sin(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) - cos(rHJY_L)*sin(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))) + cos(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)))) - (sin(rAJX_L)*sin(rAJZ_L) + cos(rAJX_L)*cos(rAJZ_L)*sin(rAJY_L))*(sin(rHJY_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rHJY_L)*sin(rHJX_L)*(cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ)) - cos(rBJX)*cos(rBJY)*cos(rHJX_L)*cos(rHJY_L)) - (sin(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))) - cos(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) - cos(rHJY_L)*sin(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))))*(cos(rAJX_L)*sin(rAJZ_L) - cos(rAJZ_L)*sin(rAJX_L)*sin(rAJY_L));
       (cos(rAJX_L)*cos(rAJZ_L) + sin(rAJX_L)*sin(rAJY_L)*sin(rAJZ_L))*(cos(rKJZ_L)*(sin(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*sin(rHJZ_L)) - sin(rKJZ_L)*(sin(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*cos(rHJZ_L))) + (cos(rAJZ_L)*sin(rAJX_L) - cos(rAJX_L)*sin(rAJY_L)*sin(rAJZ_L))*(cos(rBJY)*cos(rBJZ)*sin(rHJY_L) + cos(rHJX_L)*cos(rHJY_L)*sin(rBJY) - cos(rBJY)*cos(rHJY_L)*sin(rBJZ)*sin(rHJX_L)) - cos(rAJY_L)*sin(rAJZ_L)*(cos(rKJZ_L)*(sin(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*cos(rHJZ_L)) + sin(rKJZ_L)*(sin(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*sin(rHJZ_L))), - (cos(rAJZ_L)*sin(rAJX_L) - cos(rAJX_L)*sin(rAJY_L)*sin(rAJZ_L))*(sin(rHJY_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) + cos(rHJY_L)*sin(rHJX_L)*(cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ)) + cos(rBJY)*cos(rHJX_L)*cos(rHJY_L)*sin(rBJX)) - (cos(rAJX_L)*cos(rAJZ_L) + sin(rAJX_L)*sin(rAJY_L)*sin(rAJZ_L))*(cos(rKJZ_L)*(cos(rHJY_L)*sin(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L))) + sin(rKJZ_L)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)))) - cos(rAJY_L)*sin(rAJZ_L)*(cos(rKJZ_L)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))) - sin(rKJZ_L)*(cos(rHJY_L)*sin(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)))), (sin(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))) - cos(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) - cos(rHJY_L)*sin(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))))*(cos(rAJX_L)*cos(rAJZ_L) + sin(rAJX_L)*sin(rAJY_L)*sin(rAJZ_L)) + (cos(rAJZ_L)*sin(rAJX_L) - cos(rAJX_L)*sin(rAJY_L)*sin(rAJZ_L))*(sin(rHJY_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rHJY_L)*sin(rHJX_L)*(cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ)) - cos(rBJX)*cos(rBJY)*cos(rHJX_L)*cos(rHJY_L)) + cos(rAJY_L)*sin(rAJZ_L)*(sin(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) - cos(rHJY_L)*sin(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))) + cos(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))));
                                                                                                   sin(rAJY_L)*(cos(rKJZ_L)*(sin(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*cos(rHJZ_L)) + sin(rKJZ_L)*(sin(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*sin(rHJZ_L))) - cos(rAJX_L)*cos(rAJY_L)*(cos(rBJY)*cos(rBJZ)*sin(rHJY_L) + cos(rHJX_L)*cos(rHJY_L)*sin(rBJY) - cos(rBJY)*cos(rHJY_L)*sin(rBJZ)*sin(rHJX_L)) + cos(rAJY_L)*sin(rAJX_L)*(cos(rKJZ_L)*(sin(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*sin(rHJZ_L)) - sin(rKJZ_L)*(sin(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)) + cos(rBJY)*sin(rBJZ)*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) - cos(rBJY)*cos(rBJZ)*cos(rHJY_L)*cos(rHJZ_L))),                                                                                               sin(rAJY_L)*(cos(rKJZ_L)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))) - sin(rKJZ_L)*(cos(rHJY_L)*sin(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)))) + cos(rAJX_L)*cos(rAJY_L)*(sin(rHJY_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) + cos(rHJY_L)*sin(rHJX_L)*(cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ)) + cos(rBJY)*cos(rHJX_L)*cos(rHJY_L)*sin(rBJX)) - cos(rAJY_L)*sin(rAJX_L)*(cos(rKJZ_L)*(cos(rHJY_L)*sin(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - (cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJY)*sin(rBJX)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L))) + sin(rKJZ_L)*((cos(rBJX)*cos(rBJZ) + sin(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(cos(rBJX)*sin(rBJZ) - cos(rBJZ)*sin(rBJX)*sin(rBJY)) - cos(rBJY)*sin(rBJX)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L)))),                                                                                             cos(rAJY_L)*sin(rAJX_L)*(sin(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))) - cos(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) - cos(rHJY_L)*sin(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)))) - cos(rAJX_L)*cos(rAJY_L)*(sin(rHJY_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rHJY_L)*sin(rHJX_L)*(cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ)) - cos(rBJX)*cos(rBJY)*cos(rHJX_L)*cos(rHJY_L)) - sin(rAJY_L)*(sin(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*cos(rHJZ_L) + sin(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) + cos(rBJX)*cos(rBJY)*(cos(rHJZ_L)*sin(rHJX_L) - cos(rHJX_L)*sin(rHJY_L)*sin(rHJZ_L)) - cos(rHJY_L)*sin(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY))) + cos(rKJZ_L)*((cos(rBJZ)*sin(rBJX) - cos(rBJX)*sin(rBJY)*sin(rBJZ))*(cos(rHJX_L)*sin(rHJZ_L) - cos(rHJZ_L)*sin(rHJX_L)*sin(rHJY_L)) + cos(rHJY_L)*cos(rHJZ_L)*(sin(rBJX)*sin(rBJZ) + cos(rBJX)*cos(rBJZ)*sin(rBJY)) + cos(rBJX)*cos(rBJY)*(sin(rHJX_L)*sin(rHJZ_L) + cos(rHJX_L)*cos(rHJZ_L)*sin(rHJY_L))))];
   
    R_0footR=inv(R_footR0);
    R_0footL=inv(R_footL0);
    
    centerR=[force.copX_R(2*k); force.copY_R(2*k); force.copZ_R(2*k)];
    centerL=[force.copX_L(2*k); force.copY_L(2*k); force.copZ_L(2*k)];
    
    pos_AJL=[motion.jointX.smoothed(12,k); motion.jointY.smoothed(12,k); motion.jointZ.smoothed(12,k)];
    pos_AJR=[motion.jointX.smoothed(13,k); motion.jointY.smoothed(13,k); motion.jointZ.smoothed(13,k)];

    CPR(:,k)=R_0footR*(centerR-pos_AJR);
    CPL(:,k)=R_0footL*(centerL-pos_AJL);
    
end

clear q R_footR0 R_footL0 R_0footR R_0footL centerR centerL pos_AJL pos_AJR pBJX pBJY pBJZ rBJX rBJY rBJZ rLNJX rLNJY rLNJZ rSJX_L rSJY_L rSJZ_L rSJX_R rSJY_R rSJZ_R rEJZ_L rEJZ_R rULJX rULJY rULJZ rLLJX rLLJZ rHJX_L rHJY_L rHJZ_L rHJX_R rHJY_R rHJZ_R rKJZ_L rKJZ_R rAJX_L rAJY_L rAJZ_L rAJX_R rAJY_R rAJZ_R
ans = CPR(1,:)';
ans(isnan(ans))=0;
timeseries(ans(:,1), time(:,1),'Name','CPX_R');
save ('CPX_R','ans', '-v7.3');
ans = CPR(2,:)';
ans(isnan(ans))=0;
timeseries(ans(:,1), time(:,1),'Name','CPY_R');
save ('CPY_R','ans', '-v7.3');
ans = CPR(3,:)';
ans(isnan(ans))=0;
timeseries(ans(:,1), time(:,1),'Name','CPZ_R');
save ('CPZ_R','ans', '-v7.3');
ans = CPL(1,:)';
ans(isnan(ans))=0;
timeseries(ans(:,1), time(:,1),'Name','CPX_L');
save ('CPX_L','ans', '-v7.3');
ans = CPL(2,:)';
ans(isnan(ans))=0;
timeseries(ans(:,1), time(:,1),'Name','CPY_L');
save ('CPY_L','ans', '-v7.3');
ans = CPL(3,:)';
ans(isnan(ans))=0;
timeseries(ans(:,1), time(:,1),'Name','CPZ_L');
save ('CPZ_L','ans', '-v7.3');

%% ------------Initial configuration----------

set_param('TorqueMdl', 'StopTime', num2str(time(N)))
simOut = sim('TorqueMdl','ReturnWorkspaceOutputs','On');

%% ------------deleting input curves----------

for joint=1:length(motion.trajectoryLabels)
    delete(strcat(char(motion.trajectoryLabels(joint)), '.mat'));
end
for mvt=12:length(motion.jointLabels.smoothed)
    delete(strcat(char(motion.jointLabels.smoothed(mvt)), 'X', '.mat'));
    delete(strcat(char(motion.jointLabels.smoothed(mvt)), 'Y', '.mat'));
    delete(strcat(char(motion.jointLabels.smoothed(mvt)), 'Z', '.mat'));
end
delete('grfX_R.mat');
delete('grfX_L.mat');
delete('grfY_R.mat');
delete('grfY_L.mat');
delete('grfZ_R.mat');
delete('grfZ_L.mat');
delete('CPX_L.mat');
delete('CPX_R.mat');
delete('CPY_L.mat');
delete('CPY_R.mat');
delete('CPZ_L.mat');
delete('CPZ_R.mat');

%% filtre de janis
filterHalfOrder = 2;
filterCutOff = 20;
cycleTime=motion.frames/motion.frameRate;
timeStep = cycleTime / force.frames;
forceTimeStep = 1 /force.frameRate;
forceStartIndex = 1 ;
forceEndIndex = round(cycleTime* force.frameRate) ;
forceFrames = forceEndIndex - forceStartIndex + 1;
filterPasses = 2;
filterCorrectedCutOff = filterCutOff / ((2^(1 / filterPasses) - 1)^(1 / 4));
[filterB, filterA] = butter(filterHalfOrder, (filterCorrectedCutOff / (0.5 / forceTimeStep)));

torque.Label = motion.trajectoryLabels;
torque.Time = simOut.rKJZ_L.Time;

for tmp=1:36
    ans = getfield(simOut, char(motion.trajectoryLabels(tmp)));
    torque.estimated(tmp,:) = ans.Data;
    torque.smoothed(tmp,:) = filtfilt(filterB, filterA, torque.estimated(tmp,:));
end

%% ------------Saving output curves-----------

save (strcat('Output_', char(filename)),'motion','meta','ground','events','force','muscle','torque', '-v7.3');