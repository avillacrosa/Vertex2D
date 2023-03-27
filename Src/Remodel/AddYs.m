function Geo = AddYs(c, cj, cnew, newY, Geo)
		x = newY(1); y = newY(2);
        Geo.Cells(c).Y(end+1,:)    = [x, y];
        Geo.Cells(c).T(end+1,:)    = [c,cj,cnew];
		Geo.Cells(cj).Y(end+1,:)    = [x, y];
        Geo.Cells(cj).T(end+1,:)    = [c,cj,cnew];
		Geo.Cells(cnew).Y(end+1,:)    = [x, y];
        Geo.Cells(cnew).T(end+1,:)    = [c,cj,cnew];
end