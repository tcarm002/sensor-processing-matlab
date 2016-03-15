function sensorProcessingScript(file)


format Long G;

as = 2048;       %sensitivity of accelerometer 16g:2048 8g:2048*2
gs = 16.4;       %sensitivity of gyroscope
qs = 1073741824; %sensitivity of quaternion


%file = fileA;
data = load(file);
data(:,2) = -data(:,2);
data(:,3) = -data(:,3);
acc = data(:,2:4)/as;
gyro = data(:,5:7)/gs;
time = data(:,1);
orig_acc = data(:,2:4);


q = data(:,8:11)/qs;

q_mean = mean(q(1:100,:),1);
q = quatdivide(q, q_mean);
acc_mean = mean(acc(1:100,:),1);
acc = gravity_subtraction(acc, acc_mean, q);

serial_nums = 1;
serial_counter = zeros(length(acc),1);
for i=1 : length(acc)
    if (serial_nums <= 5000)
        serial_counter(i) = serial_nums;
    else
        serial_nums = 1;
        serial_counter(i) = serial_nums;
    end
    serial_nums = serial_nums + 1;
end

concatData = horzcat(time,serial_counter,acc,gyro,orig_acc);

if
end
savefile = 'FireFly-8A31_2013-07-03_16-42-24.txt';

dlmwrite(savefile, concatData, 'delimiter', ' ', 'precision', '%f');

end