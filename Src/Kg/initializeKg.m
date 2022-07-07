function [g, K] = initializeKg(Geo, Set)
	dimg=(Geo.numY+Geo.nCells)*2; 
	g = zeros(dimg, 1);
	K = zeros(dimg, dimg);
end