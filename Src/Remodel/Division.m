function [Geo_0, Geo_n, Geo] = Division(Geo_0, Geo_n, Geo, Dofs, Set)
	CellFields = ["X", "T", "Y", "Area", "Peri", "globalIds", "cglobalIds", "dividing", "polar"];

	randomNums = rand(Geo.nCells, 1);
	divCellsIdx = find(randomNums < Set.DivideFreq);
	for c = 1:length(divCellsIdx)
		divIdx = divCellsIdx(c);
		Geo.Cells(divIdx).dividing = true;
		Geo_0.Cells(divIdx).Area  = 2*Geo_0.Cells(divIdx).Area;
    end
%     PlotGeo(Geo)
	for c = 5
		if Geo.Cells(c).dividing
			Cell = Geo.Cells(c);
			Ys   = Cell.Y;
			x = Ys(:,1); x = [x(:); x(1)];
			y = Ys(:,2); y = [y(:); y(1)];
			%% FORCE SPLITTING BY NOW
			angleDiv = rand(1,1)*2*pi;
			angleDiv = pi/3;

            % Find position of new vertices
			slopeLine1 = tan(angleDiv);
            constLine1 = Cell.X(2)-slopeLine1*Cell.X(1);
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
                slopeLine2 = (y2(2)-y1(2))./(y2(1)-y1(1));
                constLine2 = y1(2)-slopeLine2*y1(1);
                xInt = (constLine1-constLine2)/(slopeLine2-slopeLine1);
                yInt = slopeLine1*xInt+constLine1;
                flag = inpolygon(xInt, yInt, x,y);
                if flag
                    dists = (Cell.Y(:,1)*slopeLine1+Cell.Y(:,2)+constLine1);
                    dists = dists./sqrt(slopeLine1^2+1);

                    cs = intersect(Cell.T(nY(1),:), Cell.T(nY(2),:));
                    cj = cs(cs~=c);
                    if ~exist('newCell', 'var')
                        newCell = BuildStructArray(1, CellFields);
                        newCell.Y = Geo.Cells(c).Y(dists>0,:);
                        newCell.T = Geo.Cells(c).T(dists>0,:);
                        Geo.Cells(c).Y = Geo.Cells(c).Y(dists<0,:);
                        Geo.Cells(c).T = Geo.Cells(c).T(dists<0,:);
                    end
                    % Get Cell J
                    Geo.Cells(c).Y(end+1,:)    = [xInt, yInt];
                    Geo.Cells(cj).Y(end+1,:)   = [xInt, yInt];
                    newCell.Y(end+1,:) = [xInt, yInt];
                    Geo.Cells(c).T(end+1,:)    = [c,cj,Geo.nCells+1];
                    Geo.Cells(cj).T(end+1,:)   = [c,cj,Geo.nCells+1];
                    newCell.T(end+1,:) = [c,cj,Geo.nCells+1];
                end
            end
            Geo.Cells = [Geo.Cells(1:Geo.nCells), newCell, Geo.Cells((Geo.nCells+1):end)];
            %%
            figure()
            plot(newCell.Y(:,1), newCell.Y(:,2), '-xr')
            hold on
            plot(Geo.Cells(c).Y(:,1), Geo.Cells(c).Y(:,2), '-ob')
            Geo.nCells = Geo.nCells + 1;
%         	Geo   = BuildGlobalIds(Geo);
% 			Geo   = UpdateMeasures(Geo);
        end
    end
%     PlotGeo(Geo)
end


%                 xp = linspace(Cell.X(1)-1, Cell.X(1)+1, 100);
%                 figure()
%                 plot(x,y);
%                 hold on
%                 plot(xp, slopeLine1*xp+constLine1);
%                 plot(xp, slopeLine2*xp+constLine2);
%                 plot(xInt, yInt, 'o');
%                 plot(Cell.X(1), Cell.X(2), 's', 'MarkerSize',14);