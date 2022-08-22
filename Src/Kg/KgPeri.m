function [g, K, E] = KgPeri(Geo_0, Geo, Set)
	[g, K]	= initializeKg(Geo, Set);
	E		= 0;
	for c = 1:Geo.nCells
		Cell = Geo.Cells(c);
        Cell_0 = Geo_0.Cells(c);
		Ys = Geo.Cells(c).Y;
		ge = zeros(size(g, 1), 1);
        Ke = zeros(size(g, 1));
        for yi = 1:size(Ys,1)
            if yi+1 > size(Ys,1)
                y1 = Ys(1,:);
                y2 = Ys(size(Ys,1),:);
                nY = [Cell.globalIds(1), Cell.globalIds(size(Ys,1))];
            else
                y1 = Ys(yi,:);
                y2 = Ys(yi+1,:);
                nY = [Cell.globalIds(yi), Cell.globalIds(yi+1)];
            end
	        [gl, Kl] = KgPeri_e(y1, y2);
	        ge	= Assembleg(ge,gl,nY);
	        Ke	= AssembleK(Ke,Kl,nY);
        end
		fact=Cell.Peri/Cell_0.Peri^2;
		g = g + fact*ge*Set.lambdaP;
		K = K + fact*Ke*Set.lambdaP + (ge)*(ge')/(Cell_0.Peri^2)*Set.lambdaP; 
	end
end