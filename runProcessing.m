%Run this to rename the files to a format which the toolbox will process the data
% After processing the format of the file will be 
% Col 1 -> Time
% Col 2-4 -> Acceleration with gravity
% Col 5-7 -> Gyro
% Col 8-10 -> Acceleration without gravity


fileA = uigetfile('*.txt');
outA = 'FireFly-8A31_2013-07-03_16-42-24' ;
fileB = uigetfile('*.txt');
outB = 'FireFly-8A62_2013-07-03_16-42-24' ;

  
    sensorProcessingScript(fileA, outA);
    sensorProcessingScript(fileB, outB);
