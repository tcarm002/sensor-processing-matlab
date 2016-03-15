train = 'zip.train';
test = 'zip.test';

fid = fopen(train);
%header = textscan(fid,'%s',3);            % Optionally save header names
C = textscan(fid,'%s%d%s','HeaderLines',1); % Read data skipping header
fclose(fid);                                % Don't forget to close file
C{:}