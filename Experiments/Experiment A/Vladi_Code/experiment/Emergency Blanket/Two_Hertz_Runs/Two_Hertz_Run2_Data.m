close all;
clc;


%Load the data into the matlab script.
Run_TwoHz=load('EB_2hz_r2','-mat')

%Convert the -mat file into a table. Convert the table into an array. 
Run_TwoHz_Data=table2array(struct2table(Run_TwoHz));

%The following array 300 entries of time. 
Time=Run_TwoHz_Data(:,1);

%The next three arrays store the Gyro x,y, and z data for an IMU.  
IMU_1_GyroX=Run_TwoHz_Data(:,2);
IMU_1_GyroY=Run_TwoHz_Data(:,3);
IMU_1_GyroZ=Run_TwoHz_Data(:,4);

%The next three arrays store the acceleration x,y, and z data for an IMU.  
IMU_1_AccX=Run_TwoHz_Data(:,5);
IMU_1_AccY=Run_TwoHz_Data(:,6);
IMU_1_AccZ=Run_TwoHz_Data(:,7);

%The next three arrays store the gyro x,y, and z data for an IMU.  
IMU_2_GyroX=Run_TwoHz_Data(:,8);
IMU_2_GyroY=Run_TwoHz_Data(:,9);
IMU_2_GyroZ=Run_TwoHz_Data(:,10);

%The next three arrays store the acceleration x,y, and z data for an IMU.
IMU_2_AccX=Run_TwoHz_Data(:,11);
IMU_2_AccY=Run_TwoHz_Data(:,12);
IMU_2_AccZ=Run_TwoHz_Data(:,13);

%The following array stores the position of the motor through the trial. 
Motor_position=Run_TwoHz_Data(:,14);

figure;

subplot(2,4,1)
plot(Time,Motor_position,'o-');
xlabel('Time')
ylabel('Motor_position')

subplot(2,4,2)
plot(Time,IMU_1_GyroX,'o-');
xlabel('Time')
ylabel('IMU-1-GyroX')

subplot(2,4,3)
plot(Time,IMU_1_GyroY,'o-');
xlabel('Time')
ylabel('IMU-1-GyroY')


subplot(2,4,4)
plot(Time,IMU_1_GyroZ,'o-');
xlabel('Time')
ylabel('IMU-1-GyroZ')


subplot(2,4,5)
plot(Time,IMU_1_AccX,'o-');
xlabel('Time')
ylabel('IMU-1-AccX')


subplot(2,4,6)
plot(Time,IMU_1_AccY,'o-');
xlabel('Time')
ylabel('IMU-1-AccY')


subplot(2,4,7)
plot(Time,IMU_1_AccZ,'o-');
xlabel('Time')
ylabel('IMU-1-AccZ')



figure;

subplot(2,4,1)
plot(Time,Motor_position,'o-');
xlabel('Time')
ylabel('Motor_position')


subplot(2,4,2)
plot(Time,IMU_2_GyroX,'o-');
xlabel('Time')
ylabel('IMU_2_GyroX')

subplot(2,4,3)
plot(Time,IMU_2_GyroY,'o-');
xlabel('Time')
ylabel('IMU_2_GyroY')


subplot(2,4,4)
plot(Time,IMU_2_GyroZ,'o-');
xlabel('Time')
ylabel('IMU_2_GyroZ')

subplot(2,4,5)
plot(Time,IMU_2_AccX,'o-');
xlabel('Time')
ylabel('IMU_2_AccX')

subplot(2,4,6)
plot(Time,IMU_2_AccY,'o-');
xlabel('Time')
ylabel('IMU_2_AccY')

subplot(2,4,7)
plot(Time,IMU_2_AccZ,'o-');
xlabel('Time')
ylabel('IMU_2_AccZ')



