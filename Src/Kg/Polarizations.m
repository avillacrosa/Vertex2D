function Geo = Polarizations(Geo,Set)
    D = 1;
    for c = 1:Geo.nCells
	    Geo.Cells(c).polar = Geo.Cells(c).polar + normrnd(0,2*D)*Set.dt;
    end
end