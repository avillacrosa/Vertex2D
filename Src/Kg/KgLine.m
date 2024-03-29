function [g, K, E] = KgLine(Geo_0, Geo, Set)
	[g, K]	= initializeKg(Geo, Set);
	E		= 0;
	for c = 1:Geo.nCells
		Cell   = Geo.Cells(c);
        Cell_0 = Geo_0.Cells(c);
		Ys = Geo.Cells(c).Y;
		if strcmpi(Set.BC, 'periodic')
			Ys = Ys - Geo.Cells(c).YImage.*Geo.BoxL;
		end
		Ys0 = Geo_0.Cells(c).Y;
		if strcmpi(Set.BC, 'periodic')
			Ys0 = Ys0 - Geo_0.Cells(c).YImage.*Geo.BoxL;
		end
		ge = zeros(size(g, 1), 1);
        Ke = zeros(size(g, 1));
		for yi = 1:size(Ys,1)
			if yi+1 > size(Ys,1)
    			y1 = Ys(1,:); 
    			y2 = Ys(size(Ys,1),:);
    			nY = [Cell.globalIds(1), Cell.globalIds(size(Ys,1))];
				l0 = norm(Ys0(1,:)-Ys0(size(Ys,1),:));
			else
    			y1 = Ys(yi,:);
    			y2 = Ys(yi+1,:);
    			nY = [Cell.globalIds(yi), Cell.globalIds(yi+1)];
				l0 = norm(Ys0(yi,:)-Ys0(yi+1,:));
			end
			[gl, Kl] = KgLine_e(y1, y2);
			gl = gl/l0^2;
			Kl = Kl/l0^2;
			ge	= Assembleg(ge,gl,nY);
			Ke	= AssembleK(Ke,Kl,nY);
		end
		g = g + ge*Set.lambdaL;
		K = K + Ke*Set.lambdaL;
	end
end