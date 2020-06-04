clc
clear
load('run1_935.mat');
% m = ans;
t = m(:,1);
mode1 = zeros(1,7);
mode2 = zeros(1,7);

for i = 2:7
x = m(:,i);

x = detrend(x,0);
xdft = fft(x);
freq = 0:111/length(x):111/2;
xdft = xdft(1:length(x)/2+1);
figure
plot(freq,abs(xdft));

[~,I] = max(abs(xdft));
mode1(i) = freq(I);

length(xdft);
[~,J] = max(abs(xdft(250:length(xdft),:)));
mode2(i) = freq(J);
end




