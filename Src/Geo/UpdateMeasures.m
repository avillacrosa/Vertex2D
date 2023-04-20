function Geo = UpdateMeasures(Geo)
	for c = 1:Geo.nCells
		% I'm thinking this is probably useless no?
		Cell = Geo.Cells(c);
		if any(Cell.YDistance,'all')
			Cell.Y = Cell.Y - Cell.YDistance.*Geo.BoxL;
		end
		Geo.Cells(c).Area  = ComputeCellArea(Cell); 
		Geo.Cells(c).Peri  = ComputeCellPeri(Cell);
	end
end