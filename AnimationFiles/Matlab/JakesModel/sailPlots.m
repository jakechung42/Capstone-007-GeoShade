%make some plots for the GeoShade capstone
%Author: Jake Chung
%Spring 2020
clear 
clc
close all

%% Define all parameters
th = 2.5*10^-6; %meter thickness of CP1
width = 50; %meter, width of the sail panel
Ps = 9.12*10^-6; %N/m^2 solar pressure
A = 100*50; %m^2 area of one sail
Q = 70; %distance from the center of solar sail to the COM of a sail panel

%% Set up the rotations variables
primaryRotation_rpm = 0.33; %RPM
primaryRotation_radsecond = primaryRotation_rpm*2*pi/60; %rad/s
periodPanel = 2*pi/primaryRotation_radsecond;
% periodPanel = 250;

t = linspace(0,5*periodPanel,1000); %182 is how long it takes for the sail to do 1 major rotation

angFreqPanel_1 = 0.5*2*pi/periodPanel;
angFreqPanel_2 = 0.5*2*pi/periodPanel;
angFreqPanel_3 = 0.5*2*pi/periodPanel;

verShift = 0;
timeOffset = 30.5;
panelAmp = pi/2;
%this is the most important part/
% theta1 = 0.034558/2*t;
% theta1 = zeros(1, length(t));
% theta1 = buildTheta1(length(t));
% theta2 = buildTheta2(length(t));
% theta2 = zeros(1, length(t));
% theta3 = zeros(1, length(t));
% theta3 = linspace(0,4*pi,100);
% theta2 = linspace(0,4*pi,100);
% theta2 = linspace(0,5*periodPanel,1000)*0;
% theta3 = linspace(0,4*pi,100);
% theta3 = linspace(0,5*periodPanel,1000)*0;
theta1 = panelAmp*sin(angFreqPanel_1*(t+periodPanel/3+timeOffset))+verShift;
theta2 = panelAmp*sin(angFreqPanel_2*(t+2*periodPanel/3+timeOffset))+verShift;
theta3 = panelAmp*sin(angFreqPanel_3*(t+periodPanel+timeOffset))+verShift;

phi = 0.034558*t; %use the 0.33 RPM value that Tim estimated 

figure
subplot(3,1,1)
plot(t, theta1*180/pi, 'LineWidth', 2)
ylabel('\theta_1 (degree)')
xlabel('Time (s)')
subplot(3,1,2)
plot(t, theta2*180/pi, 'LineWidth', 2)
ylabel('\theta_2 (degree)')
xlabel('Time (s)')
subplot(3,1,3)
plot(t, theta3*180/pi, 'LineWidth', 2)
ylabel('\theta_3 (degree)')
xlabel('Time (s)')

%% Torque function
Tx = -Ps*A*Q*cos(theta1).*cos(phi)-Ps*A*Q*cos(theta2).*cos(phi+2*pi/3)-Ps*A*Q*cos(theta3).*cos(phi+4*pi/3);
Ty = Ps*A*Q*cos(theta1).*sin(phi)+Ps*A*Q*cos(theta2).*sin(phi+2*pi/3)+Ps*A*Q*cos(theta3).*sin(phi+4*pi/3);

%% Plot position of each sail
Q1 = Q*[sin(phi); cos(phi)];
Q2 = Q*[sin(phi+2*pi/3); cos(phi+2*pi/3)];
Q3 = Q*[sin(phi+4*pi/3); cos(phi+4*pi/3)];

figure
subplot(3,1,1)
plot(t, Q1(1,:), 'LineWidth', 2)
hold on
plot(t, Q1(2,:), 'LineWidth', 2)
ylabel('Q_1 (rad)')
xlabel('Time (s)')
grid on

subplot(3,1,2)
plot(t, Q2(1,:), 'LineWidth', 2)
hold on
plot(t, Q2(2,:), 'LineWidth', 2)
ylabel('Q_2 (rad)')
xlabel('Time (s)')
grid on

subplot(3,1,3)
plot(t, Q3(1,:), 'LineWidth', 2)
hold on
plot(t, Q3(2,:), 'LineWidth', 2)
ylabel('Q_3 (rad)')
xlabel('Time (s)')
grid on
%% build the sail structure for animation
%define the strut of each sail
angle = 0;
base = [Q+50;0];
beam1 = rMatrix(angle)*base;
beam2 = rMatrix(120)*beam1;
beam3 = rMatrix(120)*beam2;
%define the panel 
basePanel = [[Q-50;-25],[Q-50;25],[Q+50;25],[Q+50;-25]];
p1 = zeros(2,4);
for i = 1:4
    p1(:,i) = rMatrix(angle)*basePanel(:,i); %transformation for each point
end
p2 = zeros(2,4);
for i = 1:4
    p2(:,i) = rMatrix(120)*p1(:,i); %transformation for each point
end
p3 = zeros(2,4);
for i = 1:4
    p3(:,i) = rMatrix(240)*p1(:,i); %transformation for each point
end 


%% Calculate and plot force applied on the sail
% vel_main_spin = linspace(0.01, 1,10000); %define the spin velocity rad/s
% Fc = dens*vel_main_spin.^2*width*th*1/2*(116^2-16^2);
% 
% figure
% plot(vel_main_spin, Fc)
% grid on

h = figure;
subplot(3, 3, 1)
p1t = plot(t(1), theta1(1)*180/pi, 'LineWidth', 2);
xlim([min(t), max(t)])
ylim([-180, 180])
% ylim([min(theta1), max(theta1)])
ylabel('\theta_1 (degree)')
xlabel('time (s)')
title('A')
grid on

subplot(3, 3, 7)
bodyTorque = [Tx; Ty]; %vector construction
p3t = plot(Tx(1), Ty(1), 'LineWidth', 2);
% xlim([min(Tx), max(Tx)])
% ylim([min(Ty), max(Ty)])
xlim([-2, 2])
ylim([-2, 2])
hold on
p3x = plot(Tx(1), Ty(1), 'ro', 'MarkerSize', 5);
p3y = plot([0, bodyTorque(1)],[0, bodyTorque(2)], 'LineWidth', 2);
ylabel('\tau_y')
xlabel('\tau_x')
axis equal
title('E')
grid on

subplot(3, 3, 2)
p2t = plot(t(1), theta2(1)*180/pi, 'LineWidth', 2);
xlim([min(t), max(t)])
% ylim([min(theta2), max(theta2)])
ylim([-180, 180])
ylabel('\theta_2 (degree)')
xlabel('time (s)')
title('B')
grid on

subplot(3, 3, 3)
p4t = plot(t(1), theta3(1)*180/pi, 'LineWidth', 2);
xlim([min(t), max(t)])
% ylim([min(theta3), max(theta3)])
ylim([-180, 180])
ylabel('\theta_3 (degree)')
xlabel('time (s)')
title('C')
grid on

subplot(3, 3, 4)
p5t = plot(t(1), phi(1), 'LineWidth', 2);
xlim([min(t), max(t)])
ylim([min(phi), max(phi)])
ylabel('\phi (rad)')
xlabel('time (s)')
title('D')
grid on

%plot the animation setup environment
subplot(3, 3, [5, 6, 8, 9])
hold on
%plot the first sail panel
p1a = plot([0, beam1(1)], [0, beam1(2)], 'r-', 'LineWidth', 2);
p1b = plot([p1(1,1),p1(1,2)],[p1(2,1),p1(2,2)], 'r-', 'LineWidth', 4);
p1c = plot([p1(1,2),p1(1,3)],[p1(2,2),p1(2,3)], 'r-', 'LineWidth', 4);
p1d = plot([p1(1,3),p1(1,4)],[p1(2,3),p1(2,4)], 'r-', 'LineWidth', 4);
p1e = plot([p1(1,4),p1(1,1)],[p1(2,4),p1(2,1)], 'r-', 'LineWidth', 4);

%plot the second sail panel
p2a = plot([0, beam2(1)], [0, beam2(2)], 'b-', 'LineWidth', 2);
p2b = plot([p2(1,1),p2(1,2)],[p2(2,1),p2(2,2)], 'b-', 'LineWidth', 4);
p2c = plot([p2(1,2),p2(1,3)],[p2(2,2),p2(2,3)], 'b-', 'LineWidth', 4);
p2d = plot([p2(1,3),p2(1,4)],[p2(2,3),p2(2,4)], 'b-', 'LineWidth', 4);
p2e = plot([p2(1,4),p2(1,1)],[p2(2,4),p2(2,1)], 'b-', 'LineWidth', 4);

%plot the third sail panel
p3a = plot([0, beam3(1)], [0, beam3(2)], 'g-', 'LineWidth', 2);
p3b = plot([p3(1,1),p3(1,2)],[p3(2,1),p3(2,2)], 'g-', 'LineWidth', 4);
p3c = plot([p3(1,2),p3(1,3)],[p3(2,2),p3(2,3)], 'g-', 'LineWidth', 4);
p3d = plot([p3(1,3),p3(1,4)],[p3(2,3),p3(2,4)], 'g-', 'LineWidth', 4);
p3e = plot([p3(1,4),p3(1,1)],[p3(2,4),p3(2,1)], 'g-', 'LineWidth', 4);

ylim([-70-70,70+70])
xlim([-70-70,70+70])
title('F')
axis equal
grid on


disp('Ready? Hit anykey to play')
pause()
set(h,'Position',[1,41,1536/2,1200/2]);
shg
pause(0.01)

for k = 2:length(phi)
%    Tx = -Ps*A*cos(theta1)*cos(phi(i))-Ps*A*cos(theta2)*cos(phi(i)+2*pi/3)-Ps*A*cos(theta3(i)).*cos(phi(i)+4*pi/3);
%    Ty = Ps*A*cos(theta1)*sin(phi(i))+Ps*A*cos(theta2)*sin(phi(i)+2*pi/3)+Ps*A*cos(theta3(i)).*sin(phi(i)+4*pi/3);
    
    p1t.XData = t(1:k);
    p1t.YData = theta1(1:k)*180/pi;
    
    p2t.XData = t(1:k);
    p2t.YData = theta2(1:k)*180/pi;
    
%     p3t.XData = Tx(1:k);
%     p3t.YData = Ty(1:k);
    p3x.XData = Tx(k);
    p3x.YData = Ty(k);
    p3y.XData = [0, Tx(k)];
    p3y.YData = [0, Ty(k)];
    
    p4t.XData = t(1:k);
    p4t.YData = theta3(1:k)*180/pi;
    
    p5t.XData = t(1:k);
    p5t.YData = phi(1:k); 
    
    angle = phi(k)*180/pi; %must be in degree
    beam1 = rMatrix(angle)*base;
    beam2 = rMatrix(120)*beam1;
    beam3 = rMatrix(120)*beam2;
    %define the panel 
    p1 = zeros(2,4);
    p1_noDef = zeros(2,4);
    for i = 1:4
        p1(:,i) = rMatrix(angle)*[1 0; 0 cos(theta1(k))]*basePanel(:,i); %transformation for each point
        p1_noDef(:,i) = rMatrix(angle)*basePanel(:,i);
    end
    p2 = zeros(2,4);
    for i = 1:4
        p2(:,i) = rMatrix(angle+120)*[1 0; 0 cos(theta2(k))]*basePanel(:,i); %transformation for each point
    end
    p3 = zeros(2,4);
    for i = 1:4
        p3(:,i) = rMatrix(angle+240)*[1 0; 0 cos(theta3(k))]*basePanel(:,i); %transformation for each point
    end 
    
    %update panel 1
    p1a.XData = [0, beam1(1)];
    p1a.YData = [0, beam1(2)];    
    p1b.XData = [p1(1,1),p1(1,2)];
    p1b.YData = [p1(2,1),p1(2,2)];    
    p1c.XData = [p1(1,2),p1(1,3)];
    p1c.YData = [p1(2,2),p1(2,3)];    
    p1d.XData = [p1(1,3),p1(1,4)];
    p1d.YData = [p1(2,3),p1(2,4)];    
    p1e.XData = [p1(1,4),p1(1,1)];
    p1e.YData = [p1(2,4),p1(2,1)];
    
    %update panel 2
    p2a.XData = [0, beam2(1)];
    p2a.YData = [0, beam2(2)];    
    p2b.XData = [p2(1,1),p2(1,2)];
    p2b.YData = [p2(2,1),p2(2,2)];   
    p2c.XData = [p2(1,2),p2(1,3)];
    p2c.YData = [p2(2,2),p2(2,3)];   
    p2d.XData = [p2(1,3),p2(1,4)];
    p2d.YData = [p2(2,3),p2(2,4)];   
    p2e.XData = [p2(1,4),p2(1,1)];
    p2e.YData = [p2(2,4),p2(2,1)];
    
    %update panel 3
    p3a.XData = [0, beam3(1)];
    p3a.YData = [0, beam3(2)];  
    p3b.XData = [p3(1,1),p3(1,2)];
    p3b.YData = [p3(2,1),p3(2,2)];  
    p3c.XData = [p3(1,2),p3(1,3)];
    p3c.YData = [p3(2,2),p3(2,3)];  
    p3d.XData = [p3(1,3),p3(1,4)];
    p3d.YData = [p3(2,3),p3(2,4)];  
    p3e.XData = [p3(1,4),p3(1,1)];
    p3e.YData = [p3(2,4),p3(2,1)];
    ylim([-70-70,70+70])
    xlim([-70-70,70+70])
    drawnow
    pause(0.001)
end


% figure
% plot(phi, -Ps*A*cos(theta1)*cos(phi), 'LineWidth', 2)
% hold on
% plot(phi, -Ps*A*cos(theta2)* cos(phi+2*pi/3), 'LineWidth', 2)
% plot(phi, -Ps*A*cos(theta3).*cos(phi+4*pi/3), 'LineWidth', 2)
% grid on
% 
% figure
% subplot(1,2,1)
% plot(phi, Tx, 'LineWidth', 2)
% grid on
% subplot(1,2,2)
% plot(phi, Ty, 'LineWidth', 2)
% grid on
% 
% figure
% plot(Tx,Ty, 'LineWidth', 2)
% grid on

%% function to build theta 1
function theta1 = buildTheta1(n)
%this function builds the theta1 array for the control of panel 1
%n is the size of the t array
peak = 50;
act = 10;
deact = 90;
seg1 = zeros(1,act);
seg2 = makeLinear(act+1, 0, peak, 1.3823, peak-act);
seg3 = makeLinear(peak+1, 1.3823, deact, 0, deact-peak);
seg4 = zeros(1, n-deact);
theta1 = [seg1, seg2, seg3, seg4];
end

%% function to build theta 2
function theta2 = buildTheta2(n)
%this function builds the theta1 array for the control of panel 2
%n is the size of the t array
peak = 80;
act = 50;
deact = 110;
seg1 = zeros(1,act);
seg2 = makeLinear(act+1, 0, peak, 1, peak-act);
seg3 = makeLinear(peak+1, 1, deact, 0, deact-peak);
seg4 = zeros(1, n-deact);
theta2 = [seg1, seg2, seg3, seg4];
end

%% this function makes vector from linear function from 2 sets of points
function out = makeLinear(x1, y1, x2, y2, n)
%the set of points x1 y1 x2 y2 n is the size of the vector
x = linspace(x1, x2, n);
m = (y2-y1)/(x2-x1);
coeff = y2 - m*x2;
out = m*x + coeff;
end

%% Euler's rotation vector 
function out = rMatrix(angle)
out = [cosd(angle), -sind(angle); sind(angle), cosd(angle)]; %Euler's rotation matrix
end
