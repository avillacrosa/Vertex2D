function [Geo, Mat, Set] = Compress()
    Geo.nx = 10;
    Geo.ny = 10;

	Set.BC				= 'compress';
	Set.BCdxdt			= 0.01;

	Set.RemodelTol = 0.2;
	Set.lambdaA	= 4;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.1;

	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	Set.BCPrescribed    = -2.4; 
	Set.BCFix			= 2.4;
	Set.BCStart			= 20;
	Set.BCStop			= 290;
	Set.tend			= 350;
	Set.Nincr			= 350;

    Set.MaxIter = 50;
	Set.OutputFolder='Result/CompressExample';
    Mat = struct();
end