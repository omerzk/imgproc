function H = getModel(sourcePoints, targetPoints)
%UNTITLED3 Summary of this function goes here
%   x_i' = h11*x_i + h12*y_i + h13 - h31*x_i*x_i' - h32*y_i*x_i'
%   y_i' = h21*x_i + h22*y_i + h23 - h31*x_i*y_i' - h32*y_i*y_i'

% npts = size(sourcePoints, 1);

%Extract relevant data
xSource = sourcePoints(:,1);
ySource = sourcePoints(:,2);
xTarget = targetPoints(:,1);
yTarget = targetPoints(:,2);
% A = zeros([size(xSource,1)*2 3]);
% A(1:2:end-1,1) = xSource;
% A(2:2:end,1) = ySource;
% A(1:2:end-1,2) = 1;
% A(2:2:end,3) = 1;
% b = zeros(size(xSource,1)*2,1);
% b(1:2:end-1) = xTarget;
% b(2:2:end) = yTarget;


% %Create helper vectors
% zeroVec = zeros(npts, 1);
% oneVec = ones(npts, 1);
% 
% xSourcexTarget = -xSource.*xTarget;
% ySourcexTarget = -ySource.*xTarget;
% xSourceyTarget = -xSource.*yTarget;
% ySourceyTarget = -ySource.*yTarget;

%Build matrix
% A = [xSource ySource oneVec zeroVec zeroVec zeroVec xSourcexTarget ySourcexTarget; ...
%     zeroVec zeroVec zeroVec xSource ySource oneVec xSourceyTarget ySourceyTarget];

%Build RHS vector
%b = [xTarget; yTarget];

%Solve for homography using least square.
% Hvec = A \ b;
% s = linsolve(A,b);

%Hvec(9) = 1; %Add in the redundent entry.
%H = reshape(Hvec, 3, 3)';
% H = [1 0 s(3);0 1 s(2);0 0 1];
u = mean(xTarget - xSource);
v = mean(yTarget - ySource);
H = [1 0 v;0 1 u;0 0 1];
end

