function [Geo_0, Geo_n, Geo] = Division(Geo_0, Geo_n, Geo, Dofs, Set)

	randomNums = rand(Geo.nCells, 1);
	divCellsIdx = find(randomNums < Set.DivideFreq);
	randomNums = ones(size(randomNums));
% 	for c = 1:length(divCellsIdx)
	for c = 5
		divIdx = divCellsIdx(c);
		if ~Geo.Cells(divIdx).dividing
			Geo.Cells(divIdx).dividing = true;
			Geo_0.Cells(divIdx).Area  = 2*Geo_0.Cells(divIdx).Area;
		end
	end
	for c = 1:Geo.nCells
% 		if Geo.Cells(c).dividing && Geo.Cells(c).Area > 2*Geo_0.Cells(c).Area
		if Geo.Cells(c).dividing && Geo.Cells(c).Area > 1.424
			Cell = Geo.Cells(c);
			Ys   = Cell.Y;
			x = Ys(:,1); x = [x(:); x(1)];
			y = Ys(:,2); y = [y(:); y(1)];
			%% FORCE SPLITTING BY NOW
		% 			angleDiv = rand(1,1)*2*pi;
			angleDiv = pi/2;

			%% Perform division
			[cnew, Geo]   = Divide(c, angleDiv, Geo);
			[cnew, Geo_n] = Divide(c, angleDiv, Geo_n);
		
			for li = 1:length(Ys)
				if li+1 > size(Ys,1)
					y1 = Ys(1,:);
					y2 = Ys(size(Ys,1),:);
					nY = [1, size(Ys,1)];
				else
					y1 = Ys(li,:);
					y2 = Ys(li+1,:);
					nY = [li, li+1];
				end
				slopeLine1 = tan(angleDiv);
				constLine1 = Cell.X(2)-slopeLine1*Cell.X(1);
				slopeLine2 = (y2(2)-y1(2))./(y2(1)-y1(1));
				constLine2 = y1(2)-slopeLine2*y1(1);
				xInt = (constLine1-constLine2)/(slopeLine2-slopeLine1);
				yInt = slopeLine1*xInt+constLine1;
				if inpolygon(xInt, yInt, x,y)
					cs = intersect(Cell.T(nY(1),:), Cell.T(nY(2),:));
					cj = cs(cs~=c);
					Geo   = AddYs(c, cj, cnew, [xInt, yInt], Geo);
					[Geo.Cells(cj).Y, Geo.Cells(cj).T] = ReorderYs(Geo.Cells(cj));
					Geo_n   = AddYs(c, cj, cnew, [xInt, yInt], Geo_n);
					[Geo_n.Cells(cj).Y, Geo_n.Cells(cj).T] = ReorderYs(Geo_n.Cells(cj));
				end
			end
			% Reorder after adding the vertices for the 2 new cells, but
			% not for neighboring ones as these have all the new vertices
			% inside the line loop
			[Geo.Cells(c).Y, Geo.Cells(c).T] = ReorderYs(Geo.Cells(c));
			[Geo.Cells(cnew).Y, Geo.Cells(cnew).T] = ReorderYs(Geo.Cells(cnew));
			[Geo_n.Cells(c).Y, Geo_n.Cells(c).T] = ReorderYs(Geo_n.Cells(c));
			[Geo_n.Cells(cnew).Y, Geo_n.Cells(cnew).T] = ReorderYs(Geo_n.Cells(cnew));
			%% Update Geo
			Geo    = BuildGlobalIds(Geo,Set);
			Geo_n  = BuildGlobalIds(Geo_n,Set); 
			Geo    = UpdateMeasures(Geo,Set);
			Geo_n  = UpdateMeasures(Geo_n,Set);
			%% TODO FIXME, Reference state resetted to the one after division
			% I think this should be fixed at some point?
			Geo_0 = Geo;
			Geo_0.Cells(c).Area = 0.8849;
			Geo_0.Cells(cnew).Area = 0.8849;
			Geo	  = BuildXFromY(Geo_n, Geo);
		end
	end
end