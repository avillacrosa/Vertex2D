function [Geo] = ApplyBC(t, Geo, Dofs, Set)
	if strcmpi(Set.BC, 'compress')
		prescgIds = (find(Dofs.Presc)+1)/2;
		for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
			hits = find(Cell.globalIds==prescgIds);
			Geo.Cells(c).Y(hits,1) = +1 - t*Set.BCdxdt;
		end
	end
end