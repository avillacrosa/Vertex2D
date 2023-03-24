function [Geo, Mat, Set] = pimtopo()
	%% GEO
    Geo.nx = 6;
    Geo.ny = 6;
	%% Set
	Set.lambdaA	= 2;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.005;
	Set.OutputFolder='Result/PimsTest';
		
	Set.tend			= 20;
	Set.Nincr			= 20;
	Mat = struct();
end