function H = getModel(sourcePoints, targetPoints)
%UNTITLED3 Summary of this function goes here

%Extract relevant data
xSource = sourcePoints(:,1);
ySource = sourcePoints(:,2);
xTarget = targetPoints(:,1);
yTarget = targetPoints(:,2);

u = mean(xTarget - xSource);
v = mean(yTarget - ySource);
H = [1 0 v;0 1 u;0 0 1];
end

