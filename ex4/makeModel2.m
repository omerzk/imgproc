function T = makeModel2()
%NOTE, the image points are in "image coordinates, with (1,1) at top left.
% We flip these into cartesion form, with (0,0) in the bottom left.
p1 = imCoords2cartCoords(imR,p1);
p2 = imCoords2cartCoords(imR,p2);
p3 = imCoords2cartCoords(imR,p3);
p11 = imCoords2cartCoords(imR,p11);
p22 = imCoords2cartCoords(imR,p22);
p33 = imCoords2cartCoords(imR,p33);
% Create our objects, from real and imaginary axis points.
% these are the original points...
c1 = Complex(p1(1,1),p1(1,2));
c2 = Complex(p2(1,1),p2(1,2));
c3 = Complex(p3(1,1),p3(1,2));
% these are the rotated points...
c11 = Complex(p11(1,1),p11(1,2));
c22 = Complex(p22(1,1),p22(1,2));
c33 = Complex(p33(1,1),p33(1,2));
% Create the "A" matrix......
A = zeros(6,4);
A(1,1) = real(c1.c);
A(1,2) = -imag(c1.c);
A(2,1) = real(c2.c);
A(2,2) = -imag(c2.c);
A(3,1) = real(c3.c);
A(3,2) = -imag(c3.c);
A(1,3) = 1;
A(2,3) = 1;
A(3,3) = 1;
A(4,1) = imag(c1.c);
A(4,2) = real(c1.c);
A(5,1) = imag(c2.c);
A(5,2) = real(c2.c);
A(6,1) = imag(c3.c);
A(6,2) = real(c3.c);
A(4,4) = 1;
A(5,4) = 1;
A(6,4) = 1;
b = zeros(6,1);
% Set up the b matrix.....
b(1,1) = real(c11.c);
b(2,1) = real(c22.c);
b(3,1) = real(c33.c);
b(4,1) = imag(c11.c);
b(5,1) = imag(c22.c);
b(6,1) = imag(c33.c);
%SOLVE for X =
x = A\b;
% the x vector now has r, and t...
r = Complex(x(1,1),x(2,1));
% just out of curiousity, display the angle, and the length of r
angleDegrees = r.angle() * 180/pi
disp(angleDegrees);
disp(r.length());