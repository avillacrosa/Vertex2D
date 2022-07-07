function Geo = UpdateMeasures(Geo)
	for c = 1:Geo.nCells
		% I'm thinking this is probably useless no?
		Geo.Cells(c).Area  = ComputeCellArea(Geo.Cells(c)); 
% 		Geo.Cells(c).Peri  = ComputeCellPeri(Geo.Cells(c));
	end
end