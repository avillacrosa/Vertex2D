function Geo = ReorderCells(GeoOld, finalCells)
	Geo = GeoOld;
	% Update list
	for ct = 1:length(finalCells)
    	c = finalCells(ct);
    	Geo.Cells(ct) = GeoOld.Cells(c);
	end
	% Update tets
	GeoMid = Geo;
    for ci = 1:Geo.nCells
		for ct = 1:length(finalCells)
			c = finalCells(ct);
    		Geo.Cells(ci).T(GeoMid.Cells(ci).T==c) = ct;
		end
	end
end