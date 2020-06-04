clc
clear
close all

load('run1_935.mat');
% m = ans;

bpFilt = designfilt('lowpassfir', 'FilterOrder',50,'CutoffFrequency',30, 'SampleRate', 111);
M = fftfilt(bpFilt,m);

t = 1:length(M);

for i = [2,4,5,7]
x = M(:,i); 
figure
plot(t,x);
end

run2 = input('6 values of ranges, ex: [1,2,3,4,5,6]: ');
 run4 = input('6 values of ranges, ex: [1,2,3,4,5,6]: ');
 run5 = input('6 values of ranges, ex: [1,2,3,4,5,6]: ');
 run7 = input('6 values of ranges, ex: [1,2,3,4,5,6]: ');
r2a = (run2(1):run2(2));
r2b = (run2(3):run2(4));
r2c = (run2(5):run2(6));
plot2a = M(r2a,2);
plot2b = M(r2b,2);
plot2c = M(r2c,2);

r4a = (run4(1):run4(2));
r4b = (run4(3):run4(4));
r4c = (run4(5):run4(6));
plot4a = M(r4a,4);
plot4b = M(r4b,4);
plot4c = M(r4c,4);


r5a = (run5(1):run5(2));
r5b = (run5(3):run5(4));
r5c = (run5(5):run5(6));
plot5a = M(r5a,2);
plot5b = M(r5b,2);
plot5c = M(r5c,2);


r7a = (run7(1):run7(2));
r7b = (run7(3):run7(4));
r7c = (run7(5):run7(6));
plot7a = M(r7a,2);
plot7b = M(r7b,2);
plot7c = M(r7c,2);

Cpi = 4*pi^2;

[pks2a,locs]=findpeaks(plot2a);
J = pks2a;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio2a = lamda/(sqrt(Cpi + (lamda^2)));

[pks2b,locs]=findpeaks(plot2b);
J = pks2b;
n = length(J)-1;
for k=1:n
     O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio2b = lamda/(sqrt(Cpi + (lamda^2)));

[pks2c,locs]=findpeaks(plot2c);
J = pks2c;
n = length(J)-1;
for k=1:n
     O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio2c = lamda/(sqrt(Cpi + (lamda^2)));

ratio2 = (ratio2a + ratio2b + ratio2c)/3

%seperate

[pks4a,locs]=findpeaks(plot4a);
J = pks4a;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio4a = lamda/(sqrt(Cpi + (lamda^2)));

[pks4b,locs]=findpeaks(plot4b);
J = pks4b;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio4b = lamda/(sqrt(Cpi + (lamda^2)));

[pks4c,locs]=findpeaks(plot4c);
J = pks4c;
n = length(J)-1;
for k=1:n
     O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio4c = lamda/(sqrt(Cpi + (lamda^2)));

ratio4 = (ratio4a + ratio4b + ratio4c)/3



%seperate

[pks5a,locs]=findpeaks(plot5a);
J = pks5a;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio5a = lamda/(sqrt(Cpi + (lamda^2)));

[pks5b,locs]=findpeaks(plot5b);
J = pks5b;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio5b = lamda/(sqrt(Cpi + (lamda^2)));

[pks5c,locs]=findpeaks(plot5c);
J = pks5c;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio5c = lamda/(sqrt(Cpi + (lamda^2)));

ratio5 = (ratio5a + ratio5b + ratio5c)/3

%seperate

[pks7a,locs]=findpeaks(plot7a);
J = pks7a;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio7a = lamda/(sqrt(Cpi + (lamda^2)));

[pks7b,locs]=findpeaks(plot7b);
J = pks7b;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio7b = lamda/(sqrt(Cpi + (lamda^2)));

[pks7c,locs]=findpeaks(plot7c);
J = pks7c;
n = length(J)-1;
for k=1:n
      O=log(abs((J(k))/J(k+1)));
      lamdaavg(k)=(O);
end
lamda = sum(lamdaavg)/n;
ratio7c = lamda/(sqrt(Cpi + (lamda^2)));

ratio7 = (ratio7a + ratio7b + ratio7c)/3


