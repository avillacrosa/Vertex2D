function [Geo, Mat, Set] = TEST()
    Geo.nx = 4;
    Geo.ny = 4;

	Set.RemodelTol = 0.3;
	Set.lambdaA	= 2;
	Set.lambdaP	= 0;
	Set.lambdaL	= 0;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	Set.tend			= 350;
	Set.Nincr			= 350;
    Set.nu				= 5;

    Set.MaxIter = 50;
	Set.OutputFolder='Result/Test';
    Mat = struct();
end