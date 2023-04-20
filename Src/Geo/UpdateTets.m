function Geo = UpdateVertices(Geo, dy_reshaped)
    for c = 1:Geo.nCells
        dY = dy_reshaped(Geo.Cells(c).globalIds,:);
        Geo.Cells(c).Y = Geo.Cells(c).Y + dY;
		dYc = dy_reshaped(Geo.Cells(c).cglobalIds,:); 
		Geo.Cells(c).X = Geo.Cells(c).X + dYc;
    end
end

