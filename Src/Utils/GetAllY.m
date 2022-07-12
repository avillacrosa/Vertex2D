function Ytot = GetAllY(Geo)
	Ytot = zeros(Geo.numY, 2);
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		gIds = Geo.Cells(c).globalIds;
		% TODO FIXME, overwriting going on here
		Ytot(gIds,:) = Ys;
	end
end