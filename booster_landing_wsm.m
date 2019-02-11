%  William Murphy(SID#30640826), April 18 2017, MIE124 Assignment 8
%% Booster Landing Function Option 1
%This function tracks the trajectory of the booster, which breaks off of
%the rocket at 100000m altitude,as it falls back to earth due to gravity and 
%is affected by wind and drag.It calculates whether or not it lands successfully 
%in a desired range and also the distance from the target.  

function [success, distancefromtarget] = booster_landing_wsm

%% initializing Values 
%Calling launch simulation function 
[fuelmass,Xdisplacement,altitude,velocityX,velocityY,accelerationX,accelerationY,theta,time] = launch_simulation_wsm;

%Establishing Landing Target
targetX = Xdisplacement(end)/4;

%(re)Initialzing values from simulation function
timeL = 0;
m_booster = 300000 + fuelmass(end);
velocityXL(1) = velocityX(end);
velocityYL(1) = velocityY(end);
XLdisplacement(1) = Xdisplacement(end);
altitudeL(1) = altitude(end);
%counting variable
j = 1;

%% While loop to simulate landing
while altitudeL > 0 
 
 % Calling subfunction to get drag force
 [dragforceX(j), dragforceY(j)] = force_of_air_drag_wsm(velocityXL(j), velocityYL(j), altitudeL(j));
 
 
 %Summing Forces 
 rand_windforce = [-800 800];
 
 forceX(j) = -dragforceX(j) + datasample(rand_windforce, 1);
 forceY(j) = dragforceY(j) - m_booster*9.81;
 
 %Calculating Acceleration 
 
 accelerationXL(j) = forceX(j)/m_booster; 
 accelerationYL(j) = forceY(j)/m_booster;
 
 %Accounting for terminal velocity
 if accelerationYL(j) > 0        
     accelerationYL(j) = 0; 
 else 
 end 
 %Using Euler Integration for Velocity 
 t_increment = 0.1;
 
 velocityXL(j+1) = velocityXL(j) + accelerationXL(j)*t_increment; 
 velocityYL(j+1) = velocityYL(j) + accelerationYL(j)*t_increment;
 
 %Calculating Position 
 v_avgX = (velocityXL(j+1)+ velocityXL(j))/2;
 v_avgY = (velocityYL(j+1)+ velocityYL(j))/2;

 XLdisplacement(j+1) = XLdisplacement(j) + v_avgX*t_increment;
 altitudeL(j+1) = altitudeL(j) + v_avgY*t_increment;
 
 %Reinitializing time/counting vector/variable
 timeL(j+1) = timeL(j) + t_increment; 
 j = j +1; 
end 

%Calculating Distance from Target 
distancefromtarget = abs(XLdisplacement(end)-targetX);

%Deciding whether or not mission was a success
if distancefromtarget < 500
    success = 1;
else 
    success = 0;
end 
%% plotting 
figure

% First Plot with Alt. and Disp.

plot(XLdisplacement, altitudeL) 
title('Booster X Displacement vs Booster Altitude')
xlabel('Booster X Displacement(m)')
ylabel('Booster Altitude(m)')

figure 

%Second Plot with velocities vs time

plot(timeL, velocityXL,'r')
hold on 
plot(timeL, velocityYL,'b')
xlabel('Time After Booster Detaches(s)')
ylabel('Velocity(m/s)')
title('Booster Velocity vs Time')
legend('X - velocity','Y-velocity') 
end 

