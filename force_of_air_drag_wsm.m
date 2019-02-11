%  William Murphy(SID#30640826), April 18 2017, MIE124 Assignment 8
%% Air Drag Force Function 
% This function takes inputs of component velocity and altitude from the
% other two functions and computes corresponding components of drag
% force.

function [dragforceX, dragforceY] = force_of_air_drag_wsm(velocityX, velocityY, altitude)

%Initial Values 
drag_coeff = 0.25;
Xarea = 148.29;
Yarea =  48.29;

%Calculating Density at different altitudes 
if altitude <= 100000
   air_density =  -0.000015*altitude +1.5;
else
   air_density = 0;
end 

%Calculating x & y components of drag force
dragforceX = air_density * drag_coeff*Xarea*0.5*(velocityX.^2);
dragforceY = air_density * drag_coeff*Yarea*0.5*(velocityY.^2);

end