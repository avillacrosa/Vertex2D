function Geo = RunVX(Geo, Mat, Set)
	Dofs = struct();
    Set  = InitSet(Set);
    Geo  = InitGeo(Geo, Set);
	InitiateOutputFolder(Set);
	Geo.Remodelling = false;
	t=0;
	Geo_n = Geo; Geo_0 = Geo;

	numStep = 1;
    f = PlotGeoF(Geo, Geo_0, false);
    xlim([-6,6])
    ylim([-6,6])
    fout = fullfile(pwd, Set.OutputFolder, sprintf('t_%.2f.png', 0));
    saveas(f, fout)
	while t<=Set.tend
        Geo.t = t;
		[Geo_0, Geo_n, Geo] = Remodel(Geo_0, Geo_n, Geo, Dofs, Set);
		Dofs = GetDOFs(t, Geo, Dofs, Set);
		Geo  = ApplyBC(t, Geo, Dofs, Set);
		Geo  = UpdateMeasures(Geo,Set);
		Geo  = Polarizations(Geo,Set);
		
		[g0, K0, E] = KgGlobal(Geo_0, Geo_n, Geo, Set, Dofs); 
		Geo = NewtonRaphson(Geo_0, Geo_n, Geo, Dofs, Set, K0, g0, numStep, t);
        Geo = BuildXFromY(Geo_n, Geo, Set);

        t=t+Set.dt;
        numStep=numStep+1;
        Geo_n = Geo;
        f = PlotGeoF(Geo, Geo_0, false, -g0);
        xlim([-6,6])
        ylim([-6,6])
	    fout = fullfile(pwd, Set.OutputFolder, sprintf('t_%.2f.png', t));
        saveas(f, fout)
        % close all
		fprintf('STEP has converged ...\n')
	end
end
