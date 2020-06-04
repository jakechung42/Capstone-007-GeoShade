function data = sCollect(s)

%open to collect. If program is terminated prematurely, do fclose
fopen(s);
%make the cell to collect the data
length_to_collect = 300;
%cell to store the data
collect = cell(length_to_collect, 1);
%remove the first 20 lines of the serial port 
fprintf('Begin rejecting...\n')
for i = 1:20
    temp = fgetl(s);
end
fprintf('Reject complete, start collecting\n')
%collect data continuously
for i = 1:length_to_collect
    fprintf('Collecting: ')
    disp(i)
    collect{i} = fgetl(s);
end
%convert data to num array
data = zeros(length_to_collect,14);
for i = 1:length_to_collect
    data(i, :) = str2num(collect{i});
end
%close the port
fclose(s);
end