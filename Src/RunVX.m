function Geo = RunVX(Geo, Mat, Set)
	
	Dofs = struct();
    Set  = InitSet(Set);
    Geo  = InitGeo(Geo, Set);
	InitiateOutputFolder(Set);
	Geo.Remodelling = false;
	t=0;
	Geo_n = Geo; Geo_0 = Geo;
    PostProcessingVTK(Geo_0, Geo, Set, 0);

	numStep = 1;

	while t<=Set.tend
		[Geo_0, Geo_n, Geo] = Remodel(Geo_0, Geo_n, Geo, Dofs, Set);
        PostProcessingVTK(Geo_0, Geo, Set, 1);
        return
% 		Dofs = GetDOFs(t, Geo, Dofs, Set);
% 		Geo  = ApplyBC(t, Geo, Dofs, Set);
% 		Geo  = UpdateMeasures(Geo);
% 		Geo  = Polarizations(Geo);
% 		
% 		[g, K, E] = KgGlobal(Geo_0, Geo_n, Geo, Set, Dofs); 
% 		Geo = NewtonRaphson(Geo_0, Geo_n, Geo, Dofs, Set, K, g, numStep, t);
%         Geo = BuildXFromY(Geo_n, Geo);
%         PostProcessingVTK(Geo_0, Geo, Set, numStep);
% 		fprintf('STEP has converged ...\n')
%         t=t+Set.dt;
%         numStep=numStep+1;
%         Geo_n = Geo;
	end
end
