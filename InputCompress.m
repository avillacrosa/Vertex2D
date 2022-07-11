function [Geo, Mat, Set] = InputCompress()
    Geo.nx = 4;
    Geo.ny = 3;

	Set.BC				= 'compress';
	Set.BCdxdt			= 1;
	% TODO FIXME, hard-code case, should be implemented as in V-TFM to get
	% the planes being moved and what not...
	Set.BCPrescribed    = -1; 


	Set.lambdaA	= 8;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.5;
	Set.tend	= 300;
	Set.Nincr	= 300;
    Set.MaxIter = 20;
	Set.OutputFolder='Result/Test';
    Mat = struct();
end