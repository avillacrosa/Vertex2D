function Geo = ReplaceYs(oldTets, newTets, Geo)
	% TODO FIXME, absolute mess...
	cells = unique(oldTets);
	%% Remove involved tets from every cell
	c1idx = sum(ismember(Geo.Cells(cells(1)).T, oldTets) ,2)==3;
	Geo.Cells(cells(1)).T(c1idx,:) = [];
	Geo.Cells(cells(1)).Y(c1idx,:) = [];
	c2idx = sum(ismember(Geo.Cells(cells(2)).T, oldTets) ,2)==3;
	Geo.Cells(cells(2)).T(c2idx,:) = [];
	Geo.Cells(cells(2)).Y(c2idx,:) = [];
	c3idx = sum(ismember(Geo.Cells(cells(3)).T, oldTets) ,2)==3;
	Geo.Cells(cells(3)).T(c3idx,:) = [];
	Geo.Cells(cells(3)).Y(c3idx,:) = [];
	c4idx = sum(ismember(Geo.Cells(cells(4)).T, oldTets) ,2)==3;
	Geo.Cells(cells(4)).T(c4idx,:) = [];
	Geo.Cells(cells(4)).Y(c4idx,:) = [];
	%% Add involved tets from every cell
	% TODO FIXME, forced...

	c1idxAdd = any(ismember(newTets, cells(1)) ,2);
	n1tets = newTets(c1idxAdd,:);
	for nT = 1:size(n1tets,1)
		tet =  n1tets(nT,:);
		x = [Geo.Cells(tet(1)).X; Geo.Cells(tet(2)).X; Geo.Cells(tet(3)).X];
		Geo.Cells(cells(1)).T(end+1,:) = tet;
		Geo.Cells(cells(1)).Y(end+1,:) = sum(x,1)/3;
	end
	% TODO FIXME, this should probably go into rebuild!
	[Geo.Cells(cells(1)).Y, Geo.Cells(cells(1)).T] = ReorderYs(Geo.Cells(cells(1)));
    if ~Geo.Cells(cells(1)).ghost
	    [Geo.Cells(cells(1)).Y, Geo.Cells(cells(1)).T] = ReorderYs(Geo.Cells(cells(1)));
    end

	c2idxAdd = any(ismember(newTets, cells(2)) ,2);
	n2tets = newTets(c2idxAdd,:);
	for nT = 1:size(n2tets,1)
		tet =  n2tets(nT,:);
		x = [Geo.Cells(tet(1)).X; Geo.Cells(tet(2)).X; Geo.Cells(tet(3)).X];
		Geo.Cells(cells(2)).T(end+1,:) = tet;
		Geo.Cells(cells(2)).Y(end+1,:) = sum(x,1)/3;
	end
	[Geo.Cells(cells(2)).Y, Geo.Cells(cells(2)).T] = ReorderYs(Geo.Cells(cells(2)));
    if ~Geo.Cells(cells(2)).ghost
	    [Geo.Cells(cells(2)).Y, Geo.Cells(cells(2)).T] = ReorderYs(Geo.Cells(cells(2)));
    end

	c3idxAdd = any(ismember(newTets, cells(3)) ,2);
	n3tets = newTets(c3idxAdd,:);
	for nT = 1:size(n3tets,1)
		tet =  n3tets(nT,:);
		x = [Geo.Cells(tet(1)).X; Geo.Cells(tet(2)).X; Geo.Cells(tet(3)).X];
		Geo.Cells(cells(3)).T(end+1,:) = tet;
		Geo.Cells(cells(3)).Y(end+1,:) = sum(x,1)/3;
    end
    if ~Geo.Cells(cells(3)).ghost
	    [Geo.Cells(cells(3)).Y, Geo.Cells(cells(3)).T] = ReorderYs(Geo.Cells(cells(3)));
    end

	c4idxAdd = any(ismember(newTets, cells(4)) ,2);
	n4tets = newTets(c4idxAdd,:);
	for nT = 1:size(n4tets,1)
		tet =  n4tets(nT,:);
		x = [Geo.Cells(tet(1)).X; Geo.Cells(tet(2)).X; Geo.Cells(tet(3)).X];
		Geo.Cells(cells(4)).T(end+1,:) = tet;
		Geo.Cells(cells(4)).Y(end+1,:) = sum(x,1)/3;
	end
    if ~Geo.Cells(cells(4)).ghost
	    [Geo.Cells(cells(4)).Y, Geo.Cells(cells(4)).T] = ReorderYs(Geo.Cells(cells(4)));
    end
end