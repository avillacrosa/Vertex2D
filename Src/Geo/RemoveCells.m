function Geo = RemoveCells(Geo, cellsRemove)
	% First update connectivity
	for ci = 1:length(cellsRemove)
		cR = cellsRemove(ci);
		for cj = 1:Geo.nCells
			Geo.Cells(cj).T(Geo.Cells(cj).T>=cR) = Geo.Cells(cj).T(Geo.Cells(cj).T>=cR)-1;
		end
	end

	% Then kill cells
	for ci = 1:length(cellsRemove)
		cR = cellsRemove(ci);
		Geo.Cells(cR) = [];
		cellsRemove = cellsRemove - 1;
	end
	Geo.nCells = Geo.nCells - length(cellsRemove);
end