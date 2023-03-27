function [Geo, Mat, Set] = Large()
    Geo.nx = 20;
    Geo.ny = 8;

	Set.RemodelTol = 0.0001;
	Set.lambdaA	= 2;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.005;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	
	Set.tend			= 350;
	Set.Nincr			= 350;

    Set.MaxIter = 50;
	Set.OutputFolder='Result/Large';
    Mat = struct();
end