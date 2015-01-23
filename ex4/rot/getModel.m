function H = getModel(sourcePoints, targetPoints )
%UNTITLED Summary of this function goes here
[npts, ~] = size(sourcePoints);
%Extract relevant data
sourceX = sourcePoints(:,1);
sourceY =  sourcePoints(:,2);
targetX = targetPoints(:,1);
targetY = targetPoints(:,2);

%Build matrix
A = zeros(npts*2, 4);
A(1:2:end, 1) = sourceX;
A(2:2:end, 1) = sourceY;
A(1:2:end, 2) = -sourceY;
A(2:2:end, 2) = sourceX;
A(1:2:end, 3) = 1;
A(2:2:end, 4) = 1;

%Build RHS vector
b = zeros(npts*2, 1);
b(1:2:end) = targetX;
b(2:2:end) = targetY;

%Minimize the error
Hvec = pinv(A) * b;
H = [Hvec(1), -Hvec(2), Hvec(3);
     Hvec(2), Hvec(1), Hvec(4);
     0, 0, 1];

end

