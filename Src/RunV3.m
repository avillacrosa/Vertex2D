function RunV3(Geo, Mat, Set)

	Dofs = struct(); %Bad...

    Set  = SetDefault(Set);
    Geo  = InitGeo(Geo, Set);
	Dofs = GetDOFs(Geo, Dofs, Set);
	
    PostProcessingVTK(Geo, Set, 0);

	t=0;
	Geo_n = Geo; Geo_0 = Geo;
	numStep = 1;
	while t<=Set.tend
		[g, K, E] = KgGlobal(Geo_0, Geo_n, Geo, Set); 
		[Geo, g, K, E, Set, gr, dyr, dy] = NewtonRaphson(Geo_0, Geo_n, Geo, Dofs, Set, K, g, numStep, t);
	end
end
