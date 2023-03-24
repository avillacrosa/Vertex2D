function [Geo, Mat, Set] = Propulsion()
    Geo.nx = 10;
    Geo.ny = 10;

	Set.RemodelTol = 0.0001;
	Set.lambdaA	= 2;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.005;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	
	Set.tend			= 350;
	Set.Nincr			= 350;
	Set.DivideFreq      = 1;
	Set.v0 = 0.1;
    Set.MaxIter = 50;
	Set.OutputFolder='Result/Propulsion';
    Mat = struct();
end