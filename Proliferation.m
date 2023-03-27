function [Geo, Mat, Set] = Proliferation()
    Geo.nx = 5;
    Geo.ny = 5;

	Set.RemodelTol = 0.0001;
	Set.lambdaA	= 2;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.005;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	
	Set.tend			= 50;
	Set.Nincr			= 50;
	Set.DivideFreq      = 1;
    Set.MaxIter = 50;
	Set.OutputFolder='Proliferation';
    Mat = struct();
end