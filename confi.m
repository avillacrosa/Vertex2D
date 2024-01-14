function [Geo, Mat, Set] = confi()
    Geo.nx = 10;
    Geo.ny = 10;

	Set.RemodelTol = 0.01;
	Set.lambdaA	= 3;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.001;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	
	Set.tend			= 50;
	Set.Nincr			= 50;
	Set.DivideFreq      = 1;
	Set.v0 = 0.1;
    Set.MaxIter = 50;
    Set.confR = 5;
    Set.BC = 'confinement';
	Set.OutputFolder    = 'Confinement';
    Mat = struct();
end