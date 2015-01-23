function H = getModel(sourcePoints, targetPoints)
%UNTITLED3 Summary of this function goes here

%Extract relevant data
xSource = sourcePoints(:,1);
ySource = sourcePoints(:,2);
xTarget = targetPoints(:,1);
yTarget = targetPoints(:,2);
%compute translation mean which = the most agreed upon model
u = mean(xTarget - xSource);
v = mean(yTarget - ySource);
H = [1 0 u;0 1 v;0 0 1];
end

