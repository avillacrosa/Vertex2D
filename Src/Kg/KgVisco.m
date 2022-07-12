function [g,K,EnergyF]=KgVisco(Geo_n, Geo, Set)
    K=(Set.nu/Set.dt).*eye((Geo.numY+Geo.nCells)*2);
	dY = zeros(Geo.numY+Geo.nCells,2);
	for c = 1:Geo.nCells
% 		if Geo.Remodelling
% 			if ~ismember(c,Geo.AssembleNodes)
%         		continue
% 			end
% 		end
		Cell = Geo.Cells(c);
		Cell_n = Geo_n.Cells(c);
		dY(Cell.globalIds,:) = (Cell.Y-Cell_n.Y);
		dY(Cell.cglobalIds,:) = (Cell.X-Cell_n.X);
	end
	g = (Set.nu/Set.dt).*reshape(dY', (Geo.numY+Geo.nCells)*2, 1);
	EnergyF = (1/2)*(g')*g/Set.nu;
end