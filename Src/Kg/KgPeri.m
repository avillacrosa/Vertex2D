function [g, K, E] = KgPeri(Geo_0, Geo, Set)
	[g, K]	= initializeKg(Geo, Set);
	E		= 0;
	for c = 1:Geo.nCells
		Cell = Geo.Cells(c);
		X  = Geo.Cells(c).X;
		Ys = Geo.Cells(c).Y;
		ge	  = zeros(size(g, 1), 1);
		for yi = 1:size(Ys,1)
			if t+1 > size(Ys,1)
				y1 = Ys(1,:);
				y2 = Ys(size(Ys,1),:);
				nY = [Cell.globalIds(size(Ys,1)), Cell.globalIds(1)];
			else
				y1 = Ys(t,:);
				y2 = Ys(t+1,:);
				nY = [Cell.globalIds(t), Cell.globalIds(t+1)];
			end
			[gs, Ks] = KgArea_e(y1, y2, y3);
			ge	= Assembleg(ge,gs,nY);
			K	= AssembleK(K,Ks,nY);
		end
		g=g+ge;
		K=K+(ge)*(ge'); % TODO FIXME What is this?
	end
end