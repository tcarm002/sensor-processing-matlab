clear all;

%%

w=what;
w.path
ppp=genpath(w.path)
addpath(ppp)
path


%%
load('align_merge.mat');
data;
%data(:,8)=data(:,8)/2048/256;
%data(:,9)=data(:,9)/2048/256;
%data(:,10)=data(:,10)/2048/256;
%These are the rows in which your starting time and ending time are located
%inside the data file
startPoint =1000;%2300;%1800;%6200;%5700; %840;
endPoint =7900;%3499;%4199;%7399;%4200;%6500; %1017;
SamplingFactor=1;
rowIndexDifference = (endPoint-startPoint)/SamplingFactor;

time = data(startPoint:SamplingFactor:endPoint, 1);


% time = data(:, 1);
 %acceleration = data(:, 2)*9.8;

velocity = zeros(rowIndexDifference,1);
 %velocity = zeros(length(acceleration),1);


Kinect_leftWristY=data_skeleton(startPoint:SamplingFactor:endPoint,17);
t_smpl=0.005*SamplingFactor;
%t_smpl=0.02;
%[xx,temp1] = gradient(Kinect_leftWristX, t_smpl);
%[xx,virtual_accX] = gradient(temp1,t_smpl);

%==============

    
%
figure; 
subplot(6,1,1);
plot(Kinect_leftWristY,'g','LineWidth',1);
ylim([-1 1]);
title('Kinect Position');

%
temp1 = diff(Kinect_leftWristY)./t_smpl;
virtual_accY = diff(temp1)./t_smpl;

subplot(6,1,2);
plot(virtual_accY/9.8,'LineWidth',1);
ylim([-4 4]);
title('Virtual Acc');

%
temp1 = diff(Kinect_leftWristY)./t_smpl;
%temp1(:) = natural_spline(temp1(:));
temp1(:) = smooth(temp1(:),0.02,'lowess');
virtual_accY_SM = diff(temp1)./t_smpl;

subplot(6,1,4);
plot(virtual_accY_SM/9.8,'LineWidth',1);
ylim([-1 1]);
title('Virtual Acc w V-smoothing');

%
%Kinect_leftWristY(:) = natural_spline(Kinect_leftWristY(:));
Kinect_leftWristY(:) = smooth(Kinect_leftWristY(:),0.02,'lowess');

temp1 = diff(Kinect_leftWristY)./t_smpl;
virtual_accY_SM = diff(temp1)./t_smpl;

subplot(6,1,3);
plot(virtual_accY_SM/9.8,'LineWidth',1);
ylim([-1 1]);
title('Virtual Acc w P-smoothing');

%
temp1 = diff(Kinect_leftWristY)./t_smpl;
%temp1(:) = natural_spline(temp1(:));
temp1(:) = smooth(temp1(:),0.02,'lowess');
virtual_accY_SM = diff(temp1)./t_smpl;

subplot(6,1,5);
plot(virtual_accY_SM/9.8,'LineWidth',1);
ylim([-1 1]);
title('Virtual Acc w PV-smoothing');

%

acceleration = data(startPoint:SamplingFactor:endPoint, 3)*9.8;
%origAcc = data(startPoint:SamplingFactor:endPoint, 9)*9.8;

subplot(6,1,6);
plot(-acceleration/9.8,'r','LineWidth',1);
ylim([-1 1]);
title('Actual Acc');




