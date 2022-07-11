clear; close all; clc;
addpath(genpath('Src'));
Set = struct();
Set.nu = 0.05;
Set.dt = 1;
Set.tend=300;
Set.Nincr=300;
Set.MaxIter = 10;
Set.OutputFolder='Result/Test';InitiateOutputFolder(Set);
Set.lambdaA					= 2;
Set.lambdaP					= 0.5;
Set.lambdaL					= 0.5;

theta = 0.5;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];

Geo = struct(); Geo.Cells = struct();
Geo.Cells(1).X = [0 0];
% Geo.Cells(1).Y = [0 -1; 1 0;  0 1; -1 0]; % SQUARE
% Geo.Cells(1).Y = [1 0; cos(pi/4) sin(pi/4); cos(3*pi/4) sin(3*pi/4); cos(pi) sin(pi);cos(5*pi/4) sin(5*pi/4);cos(7*pi/4) sin(7*pi/4)]; % REGULAR HEXAGON
Geo.Cells(1).Y = [
   -0.3333   -0.3333
   -0.6667    0.3333
   -0.3333    0.6667
    0.3333    0.3333
    0.6667   -0.3333
    0.3333   -0.6667];

% Geo.Cells(1).Y = Geo.Cells(1).Y*R;

Geo.Cells(1).globalIds = 1:size(Geo.Cells(1).Y,1);
Geo.Cells(1).cglobalIds = size(Geo.Cells(1).Y,1)+1;
Geo.Cells(1).Peri = ComputeCellPeri(Geo.Cells(1));
Geo.Cells(1).Area = ComputeCellArea(Geo.Cells(1));

Geo.numY = size(Geo.Cells(1).Y,1);
Geo.nCells = 1;
dy = zeros((Geo.numY+Geo.nCells)*2, 1);

Geo_0 = Geo;
%% This has a big effect on the solution
% Geo_0.Cells(1).Y = Geo_0.Cells(1).Y/2;
% Geo_0.Cells(1).Area = ComputeCellArea(Geo_0.Cells(1));
%%
Geo_n = Geo;

dofs = 1:(Geo.numY*2);
Dofs.Free = dofs;
it = 0;
g = zeros((Geo.numY+Geo.nCells)*2,1);
K = zeros((Geo.numY+Geo.nCells)*2);
fprintf("it:%d , gr: %e , dyr: %e , peri: %f, Area: %d, dArea: %f\n", ...
	it, norm(g(dofs)), norm(dy(dofs)), Geo.Cells(1).Peri, Geo.Cells(1).Area, Geo.Cells(1).Area-Geo_0.Cells(1).Area);
PostProcessingVTK(Geo,Set,0);

while it < 10
	[g,K,~] = KgGlobal(Geo_0, Geo_n, Geo, Set);

	dy(dofs) = -K(dofs, dofs)\g(dofs);
	alpha = LineSearch(Geo_0, Geo_n, Geo, Dofs, Set, g, dy);
	dy_reshaped = reshape(dy * alpha, 2, (Geo.numY+Geo.nCells))';
	
	Geo = UpdateVertices(Geo, dy_reshaped);
	Geo = UpdateMeasures(Geo);
	PostProcessingVTK(Geo,Set,it+1);
	[g,K,E]=KgGlobal(Geo_0, Geo_n, Geo, Set);
	fprintf("it:%d , alpha: %e, gr: %e , dyr: %e , peri: %f, Area: %d, dArea: %f\n", ...
	it, alpha, norm(g(dofs)), norm(dy(dofs)), Geo.Cells(1).Peri, Geo.Cells(1).Area, Geo.Cells(1).Area-Geo_0.Cells(1).Area);
	it = it+1;
end