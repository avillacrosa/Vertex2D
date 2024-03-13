function [Geo, Mat, Set] = confi()
    Geo.nx = 10;
    Geo.ny = 10;

	Set.RemodelTol = 0.1;
	Set.lambdaA	= 1;
	Set.lambdaP	= 0.05;
	Set.lambdaL	= 0.00;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	
	Set.tend			= 1;
	Set.Nincr			= 1;
	Set.v0 = 0.01;
    Set.MaxIter = 50;
    Set.confR = 4.5;
    Set.BC = 'confinement';
	Set.OutputFolder    = 'Confinement';
    Mat = struct();
end