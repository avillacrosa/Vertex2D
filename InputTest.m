function [Geo, Mat, Set] = InputTest()
    Geo.nx = 4;
    Geo.ny = 3;

	Set.lambdaA	= 8;
	Set.lambdaP	= 0.5;
	Set.lambdaL	= 0.5;
	Set.tend	= 300;
	Set.Nincr	= 300;
    Set.MaxIter = 20;
	Set.OutputFolder='Result/Test';
    Mat = struct();
end