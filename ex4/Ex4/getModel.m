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

%Extract relevant data
% xSource = sourcePoints(:,1);
% ySource = sourcePoints(:,2);
% xTarget = targetPoints(:,1);
% yTarget = targetPoints(:,2);
% A = zeros([size(xSource,1)*2 3]);
% A(1:2:end-1,1) = xSource;
% A(2:2:end,1) = ySource;
% A(1:2:end-1,2) = 1;
% A(2:2:end,3) = 1;
% b = zeros(size(xSource,1)*2,1);
% b(1:2:end-1) = xTarget;
% b(2:2:end) = yTarget;
% s = linsolve(A,b);
% H = [1 0 s(2);0 1 s(3);0 0 1];
end

