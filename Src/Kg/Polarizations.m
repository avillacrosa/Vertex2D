function Geo = Polarizations(Geo)
	rads	= rand([Geo.nCells,1])*2*pi;
	ps		= [cos(rads), sin(rads)];
	for c = 1:Geo.nCells
		Geo.Cells(c).polar = ps(c,:);
	end
end