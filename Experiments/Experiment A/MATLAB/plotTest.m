function[] = plotTest(data)
%this function plots the test data output from the Due
data(:,1) = data(:,1)*10^-3;
data(:,end) = data(:,end)*180/512;
subplot(7,1,1)
plot(data(:,1),data(:,end))
for i = 2:7
    subplot(7,1,i)
    plot(data(:,1),data(:,i),'o-')
    grid on
end
end