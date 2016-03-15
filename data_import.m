function [t, orientation, acceleration, acceleration_R, omega, mag] = data_import( input_name )
%DATA_IMPORT Summary of this function goes here
% read calibration reading from the latest log file
%   Detailed explanation goes here



% if there is an input name, then read the input name instead
if nargin > 0
    log = input_name;
else
    % read the file
    log = d(latest_idx).name;
    % get all logs
    d = dir('2012*');
    
    % look for the latest one
    filedate = [d.datenum];
    [~, latest_idx] = max(filedate);
end

% read data
if ~isempty(log)
fid = fopen(log);

count = 0;

data = zeros(13, 0);
while ~feof(fid)
    count = count + 1;
    
    try
        line = fgetl(fid);
        C = textscan(line, '#YPR=%f,%f,%f #A=%f,%f,%f #G=%f,%f,%f #M=%f,%f,%f #dt=%f', 13);
        data(:, count) = [C{:}].';
    catch
        try
            line = fgetl(fid);
            C = textscan(line, '#YPR=%f,%f,%f #A=%f,%f,%f #G=%f,%f,%f #M=%f,%f,%f #dt=%f', 13);
            data(:, count) = [C{:}].';
        catch
            
            count = count - 1;
        end
    end
end

fclose(fid);

% plot orientation and acceleration, data acquire
orientation = data(1:3, :)/180*pi; % Orientation (in Rad)
acceleration = data(4:6, :);
g = 256; % LSB/g
acceleration = acceleration/g*9.8;
omega = data(7:9, :);
GYRO_GAIN = 0.06957;
omega = omega *GYRO_GAIN / 180 * pi;
mag = data(10:12, :);

% Direct cosine matrices
dcm = angle2dcm(orientation(1, :).', orientation(2, :), orientation(3, :));

% Rotation
acceleration_R = nan(size(acceleration));
for i = 1:size(acceleration, 2)
    acceleration_R(:, i) = dcm(:, :, i).' * acceleration(:, i);
end

% Time difference (in second), actual sampling time
dT = data(13, :)/1000;
t = cumsum(dT); % actual time indies


% interpolate the data
ti = t(1):mean(dT):t(end);
orientationi = interp1(t, orientation', ti)';
accelerationi = interp1(t, acceleration', ti)';
acceleration_Ri = interp1(t, acceleration_R', ti)';
omegai = interp1(t, omega', ti)';
magi = interp1(t, mag', ti)';


end

% assign to workspace
if nargout == 0
    assignin('base', 't', ti');
    assignin('base', 'orientation', orientationi');
    assignin('base', 'acceleration', accelerationi');
    assignin('base', 'acceleration_R', acceleration_Ri');
    assignin('base', 'omega', omegai');
    assignin('base', 'magnent', magi');
else
    t = ti';
    orientation = orientationi';
    acceleration = accelerationi';
    acceleration_R = acceleration_Ri';
    omega = omegai';
    mag = magi';
end