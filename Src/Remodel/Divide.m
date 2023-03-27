function [newCellIdx, Geo] = Divide(c, angle, Geo)
	newCellIdx = (Geo.nCells+1);
	CellFields = ["X", "T", "Y", "Area", "Peri", "globalIds", "cglobalIds", "dividing", "polar"];
	Cell = Geo.Cells(c);
	slopeLine1 = tan(angle);
    constLine1 = Cell.X(2)-slopeLine1*Cell.X(1);

    projectLine1 = slopeLine1*Geo.Cells(c).Y(:,1)+constLine1;
	aboveLine1   = Geo.Cells(c).Y(:,2) > projectLine1;
	newCell   = BuildStructArray(1, CellFields);
	newCell.Y = Geo.Cells(c).Y(~aboveLine1,:);
	newCell.T = Geo.Cells(c).T(~aboveLine1,:);
	newCell.X = Geo.Cells(c).X;
	newCell.dividing = false;
	newCell.polar = [];
	newCell.globalIds = Geo.Cells(c).globalIds(~aboveLine1,:);
	newCell.T(newCell.T==c) = newCellIdx;
	neighbCells = unique(newCell.T);
	neighbCells = neighbCells(neighbCells~=newCellIdx);
	for ni = 1:length(neighbCells)
		neighCell = neighbCells(ni);
		neighYIds = newCell.globalIds;
		for gi = 1:length(neighYIds)
			gId = neighYIds(gi);
			idxs = find(Geo.Cells(neighCell).globalIds==gId);
			if any(idxs)
				Geo.Cells(neighCell).T(idxs,:) = newCell.T(gi,:);
			end
		end
	end
	Geo.Cells(c).Y = Geo.Cells(c).Y(aboveLine1,:);
	Geo.Cells(c).T = Geo.Cells(c).T(aboveLine1,:);
	Geo.Cells(c).dividing = false;
	Geo.Cells  = [Geo.Cells(1:Geo.nCells), newCell, Geo.Cells(newCellIdx:end)];
	Geo.nCells = Geo.nCells + 1;
end