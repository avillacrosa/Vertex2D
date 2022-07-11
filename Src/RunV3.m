function RunV3(Geo, Mat, Set)
	
	Dofs = struct();
    Set  = SetDefault(Set);
    Geo  = InitGeo(Geo, Set);
	Dofs = GetDOFs(Geo, Dofs, Set);
	InitiateOutputFolder(Set);


	t=0;
	Geo_n = Geo; Geo_0 = Geo;
    PostProcessingVTK(Geo_0, Geo, Set, 0);

	numStep = 1;

	while t<=Set.tend
		Geo = ApplyBC(t, Geo, Dofs, Set);
		Geo = UpdateMeasures(Geo);
		
		[g, K, E] = KgGlobal(Geo_0, Geo_n, Geo, Set, Dofs); 

		[Geo, g, K, E, Set, gr, dyr, dy] = NewtonRaphson(Geo_0, Geo_n, Geo, Dofs, Set, K, g, numStep, t);
        Geo = BuildXFromY(Geo_n, Geo);
        PostProcessingVTK(Geo_0, Geo, Set, Set.iter);

        return
	end
end
