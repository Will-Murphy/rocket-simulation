%  William Murphy(SID#30640826), April 18 2017, MIE124 Assignment 8
%% Launch Simulation Function
% This function only the initial conditions of the given rocket,equations from newtonion
% physics and euler integration to predict the charateristics/physical
% conditions of a rocket launch. 

function [fuelmass,Xdisplacement,altitude,velocityX,velocityY,accelerationX,accelerationY,theta,time] = launch_simulation_wsm

%% Initial Rocket Conditions 
m_rocket = 300000;

fuelmass(1) = 400000;

thruster_force = 7000000;

%% Initial while loop conditions 

% Real Variables 
time = 0;
theta = 90; 
altitude = 0; 
Xdisplacement = 0;
velocityX = 0;
velocityY = 0;
 
%Counting Variable 

j = 1; 

%% While Loop for Launch Simulation 
while altitude < 100000

% Calling subfunction to get drag force
[dragforceX(j), dragforceY(j)] = force_of_air_drag_wsm(velocityX(end), velocityY(end), altitude(end));

%summing total force

force_X(j) = -dragforceX(j) + thruster_force*cosd(theta(j));

force_Y(j) = thruster_force*sind(theta(j)) - 9.81*(m_rocket+fuelmass(j)) - dragforceY(j);  
    
% Calculating Acceleration 

accelerationX(j) = force_X(j)/(m_rocket + fuelmass(j)); 
accelerationY(j) = force_Y(j)/(m_rocket + fuelmass(j));

% Using Euler Intergration for velocity 

t_increment = 0.1;

velocityX(j+1) = velocityX(j) + accelerationX(j)*t_increment;
velocityY(j+1) = velocityY(j) + accelerationY(j)*t_increment;

% Calculating position
v_avgX = (velocityX(j+1)+ velocityX(j))/2;
v_avgY = (velocityY(j+1)+ velocityY(j))/2;

Xdisplacement(j+1) = Xdisplacement(j) + v_avgX*t_increment;
altitude(j+1) = altitude(j) + v_avgY*t_increment;

% Updating Fuelmass 
fuelmass(j+1) = fuelmass(j) - 1000*t_increment;

% Updating theta 
theta(j+1) = 90;

if altitude(end) >= 50000
theta(j+1) = theta(j) - 0.5;
else 
end 

if theta(j+1) <= 55 
    theta(j+1) = 55;
else 
end 

time(j+1) = time(j) + t_increment;
j = j + 1;
end 
%% Graphing Flight Simulation Results 

% X displacement vs altitude plot
plot(Xdisplacement, altitude)
axis('equal') 
hold on 
k = (velocityX > 0 & velocityX < 0.015);
plot(Xdisplacement(k), 50000, 'ro')
title('X displacement vs altitude plot')
xlabel('Xdisplacement(m)')
ylabel('Altitude(m)') 
hold off

% Acceleration vs time plot
figure 

plot(time(2:end), accelerationX ,'b-')
hold on 
plot(time(2:end), accelerationY, 'k-')
plot(time(k),accelerationX(k+1),'ro')
plot(time(k),accelerationY(k),'ro')
xlabel('time(s)')
ylabel('acceleration(m/s^2')
title('Acceleration vs time plot')
legend('X-acceleration','Y-acceleration')
hold off



end 

 











 