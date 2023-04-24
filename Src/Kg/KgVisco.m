function [g,K,EnergyF]=KgVisco(Geo_n, Geo, Set)
    K=(Set.nu/Set.dt).*eye((Geo.numY+Geo.nCells)*2);
	dY = zeros(Geo.numY+Geo.nCells,2);
	for c = 1:Geo.nCells
		Cell = Geo.Cells(c);
		Cell_n = Geo_n.Cells(c);
		Cell.Y = Geo.Cells(c).Y;
		if strcmpi(Set.BC, 'periodic')
			Cell.Y = Cell.Y - Geo.Cells(c).YImage.*Geo.BoxL;
		end
		
		Cell_n.Y = Geo_n.Cells(c).Y;
		if strcmpi(Set.BC, 'periodic')
			Cell_n.Y = Cell_n.Y - Geo_n.Cells(c).YImage.*Geo.BoxL;
		end
		dY(Cell.globalIds,:) = (Cell.Y-Cell_n.Y);
		dY(Cell.cglobalIds,:) = (Cell.X-Cell_n.X);
	end
	g = (Set.nu/Set.dt).*reshape(dY', (Geo.numY+Geo.nCells)*2, 1);
	EnergyF = (1/2)*(g')*g/Set.nu;
end