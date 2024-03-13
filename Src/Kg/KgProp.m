function [g, K, E] = KgProp(Geo, Set)
	[g, K]	= initializeKg(Geo, Set);
	E		= 0;
	for c = 1:Geo.nCells
		YIds = Geo.Cells(c).globalIds(:);
		TIds = Geo.Cells(c).T;
		Ni   = sum(ismember(TIds, find(Geo.XgID)),2);
		if any(Ni==0)
			Ni(Ni==0)=1;
		end
		ge = Geo.Cells(c).polar./Ni;
		ge = ge';
		g  = Assembleg(g,ge(:),YIds);
	end
	g = g*Set.nu*Set.v0;
end