function [g, K, E] = KgArea(Geo_0, Geo, Set)
	[g, K]	= initializeKg(Geo, Set);
	E		= 0;
	for c = 1:Geo.nCells
		Cell = Geo.Cells(c);
		X  = Geo.Cells(c).X;
		Ys = Geo.Cells(c).Y;
		for t = 1:size(Ys,1)
			if t+1 > size(Ys,1)
				y1 = Ys(0,:);
				y2 = Ys(size(Ys,1),:);
				nY = [Cell.globalIds(size(Ys,1)), Cell.globalIds(0), Cell.cglobalIds];
			else
				y1 = Ys(t,:);
				y2 = Ys(t+1,:);
				nY = [Cell.globalIds(t), Cell.globalIds(t+1), Cell.cglobalIds];
			end
			y3 = X;
			[gs, Ks, Kss] = KgArea_e(y1, y2, y3);
			ge	= Assembleg(ge,gs,nY);
			K	= AssembleK(K,Ks,nY);
		end
		g=g+ge*fact;
		K=K+(ge)*(ge')/(Cell.Area0^2);
	end
end