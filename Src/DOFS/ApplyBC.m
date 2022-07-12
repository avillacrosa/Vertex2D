function [Geo] = ApplyBC(t, Geo, Dofs, Set)
	if strcmpi(Set.BC, 'compress') && t > Set.BCStart && t < Set.BCStop
		prescgIds = (find(Dofs.Presc)+1)/2;
		fixIds = (find(Dofs.Fix)+1)/2;
		for c = 1:Geo.nCells
			Cell = Geo.Cells(c);
			hitsP = ismember(Cell.globalIds, prescgIds);
			hitsF = ismember(Cell.globalIds, fixIds);
			Geo.Cells(c).Y(hitsP,1) = Set.BCPrescribed + (t-Set.BCStart)*Set.BCdxdt;
			Geo.Cells(c).Y(hitsF,1) = Set.BCFix;
		end
	end
end