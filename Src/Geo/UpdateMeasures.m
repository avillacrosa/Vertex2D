function Geo = UpdateMeasures(Geo, Set)
	for c = 1:Geo.nCells
		Cell = Geo.Cells(c);
		if strcmpi(Set.BC, 'periodic')
			Cell.Y = Cell.Y - Cell.YImage.*Geo.BoxL;
		end
		Geo.Cells(c).Area  = ComputeCellArea(Cell); 
		Geo.Cells(c).Peri  = ComputeCellPeri(Cell);
% 		c, Geo.Cells(c).Area, Geo.Cells(c).Peri
% 		fprintf("%d, %.2f, %.2f\n", c, Geo.Cells(c).Area, Geo.Cells(c).Peri);
	end
end