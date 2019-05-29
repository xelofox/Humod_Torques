close all;
clear all;
clc;

% Load female straight walking dataset
data = load('6.mat');

% Find the index of the right knee joint in the cell array of trajectory
% labels where the individual letters in the label 'rKJZ_R' have the
% following meaning:
% r: revolute joint
% KJ: knee joint
% Z: rotation about local z-axis
% R: right side
indexKJ_R = find(strcmp(data.motion.trajectoryLabels, 'rLNJZ'));

% Plot the right knee joint angle
timeKJ_R = 0:(1 / data.motion.frameRate):((data.motion.frames - 1) / data.motion.frameRate);
plot(timeKJ_R, data.motion.trajectory.q(indexKJ_R, :));
xlabel('Time in s');
ylabel('Right knee angle in rad');