function [Geo_0, Geo_n, Geo] = Division(Geo_0, Geo_n, Geo, Dofs, Set)
	randomNums = rand(Geo.nCells, 1);
	divCellsIdx = find(randomNums < Set.DivideFreq);
	for c = 1:length(divCellsIdx)
		divIdx = divCellsIdx(c);
		Geo.Cells(divIdx).dividing = true;
		Geo_0.Cells(divIdx).Area  = 2*Geo_0.Cells(divIdx).Area;
	end
	%%
	for c = 1:Geo.nCells
		if Geo.Cells(c).dividing
			Cell = Geo.Cells(c);
			Ys   = Cell.Y;
			x = Ys(:,1); x = [x(:); x(1)];
			y = Ys(:,2); y = [y(:); y(1)];
			%% FORCE SPLITTING BY NOW
			angleDiv = rand(1,1)*2*pi;
			angleDiv = pi/4;
			slopeLine1 = tan(angleDiv);
			xl = [min(x), max(x)];
			yl = (xl-Geo.Cells(c).X(1)).*slopeLine1+Geo.Cells(c).X(1);
			[xi,yi] = polyxpoly(x,y,xl,yl,'unique');

			for cj = 1:length(xi)
				Cell.T
			end
			Geo.Cells(c).Y(end+1) = [xi(1),yi(1)];
			Geo.Cells(c).Y(end+1) = [xi(2),yi(2)];
			1
% 			Geo.Cells(c).Y = 
% 			%% THESE TWO SHOULD BE EQUIVALENT NO?
% 			if Geo.Cells(c).Area == Geo_0.Cells(c).Area
% 				angleDiv = rand(1,1)*2*pi;
% 
% 			end
		end
	end
end