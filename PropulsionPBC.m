function [Geo, Mat, Set] = PropulsionPBC()
    Geo.nx = 3;
    Geo.ny = 3;

	Set.RemodelTol = 0.0001;
	Set.lambdaA	= 5;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	
	Set.tend			= 50;
	Set.Nincr			= 50;
	Set.DivideFreq      = 1;
	Set.v0 = 0.5;
	Set.BC = 'periodic';
	Set.Box = 8;
    Set.MaxIter = 50;
	Set.OutputFolder='PropulsionPBC';
    Mat = struct();
end