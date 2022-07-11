function PostProcessingVTK(Geo_0, Geo, Set, Step)
	CreateVtkCell(Geo_0, Geo, Set, Step);
	CreateVtkCellAll(Geo_0, Geo, Set, Step);
% 	CreateVtkConn(Geo, Set, Step)
end 