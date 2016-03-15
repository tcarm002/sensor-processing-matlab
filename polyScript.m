%Script performs a zero-velocity update and calculates the distance of a given time interval

clear all;
load('align_merge.mat');
data;

%These are the rows in which your starting time and ending time are located inside the align_merge file inside the data table
startPoint =  2570 ;
endPoint =  3045 ;
rowIndexDifference = endPoint-startPoint;
time = data(startPoint:endPoint, 1);
dataColumn = 3  ; %the column of data you want to calculate the distance from. Column 2, 3 ,4 are generally the accelerometer 
acceleration = data(startPoint:endPoint, dataColumn) * 9.8;
velocity = zeros(rowIndexDifference,1);
deltaX = zeros(1,rowIndexDifference);

for idx=2:length(acceleration)
    timeDiff = time(idx) - time(idx-1);
    velocity(idx) = acceleration(idx-1) * timeDiff + velocity(idx-1);
    
end
polyFitLine = polyfit([time(1) time(rowIndexDifference)],[velocity(1) velocity(rowIndexDifference)],1);
polyFitVals = polyval(polyFitLine,time);
velocity=velocity-polyFitVals;

for idx=2:length(acceleration)
    timeDiff = time(idx) - time(idx-1);
    deltaX(idx-1) =  velocity(idx-1) * timeDiff + .5*acceleration(idx-1)*timeDiff^2;
end
sum(deltaX) %total distance traveled in interval




