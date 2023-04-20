function AllTs = GetAllT(Geo)
	AllTs = [];
	for ci = 1:Geo.nCells
		Ts = unique(Geo.Cells(ci).T);
		AllTs = [AllTs; Ts];
	end
	AllTs = unique(AllTs);
end