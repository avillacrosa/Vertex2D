function [Geo, Mat, Set] = noPBC()
    Geo.nx = 8;
    Geo.ny = 8;

	Set.RemodelTol = 0.0001;
	Set.lambdaA	= 5;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.0001;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	
	Set.tend			= 50;
	Set.Nincr			= 50;
	Set.DivideFreq      = 1;
	Set.v0 = 0.1;
    Set.MaxIter = 50;
	Set.OutputFolder='NoPBC';
    Mat = struct();
end