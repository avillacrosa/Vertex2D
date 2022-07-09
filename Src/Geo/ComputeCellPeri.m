function peri = ComputeCellPeri(Cell)
	peri = 0;
	for yi = 1:(size(Cell.Y,1))
        if yi+1 > size(Cell.Y,1)
		    y1 = Cell.Y(size(Cell.Y,1),:);
		    y2 = Cell.Y(1,:);
        else
            y1 = Cell.Y(yi,:);
		    y2 = Cell.Y(yi+1,:);
        end
		l = (y1-y2)';
		peri = peri + norm(l);
	end
end