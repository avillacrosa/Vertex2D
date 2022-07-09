function [Geo, Mat, Set] = InputTest()
    Geo.nx = 3;
    Geo.ny = 3;

	Set.tend=300;
	Set.Nincr=300;
%     Set.nu	= 1;
    Set.MaxIter = 10;
	Set.OutputFolder='Result/Test';
    Mat = struct();
end