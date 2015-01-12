function Tout = imgToPanoramaCoordinates(Tin)
% Tout{k} transforms image i to the coordinates system of the Panorama Image. %
% Arguments:
% Tin ? A set of transformations (cell array) such that T i transfroms
% image i+1 to image i. %
% Returns:
% Tout ? a set of transformations (cell array) such that T i transforms
% image i to the panorama corrdinate system which is the the corrdinates
% system of the first image.
Tout = cell(size(Tin, 2) + 1);
Tout{1} = eye(3);
for k = 1:size(Tin, 2)
    Tout{k + 1} = Tout{k} / Tin{k};
    % Inverse of the input T's so that the final transformations are from m to 0
    % TODO:Consider making Tin s.t Ti+1 is Imi+1 to Imi(fit their def better)
end
end