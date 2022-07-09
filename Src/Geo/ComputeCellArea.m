function area = ComputeCellArea(Cell)
	area = 0;
	Q = [0 1; -1 0];
	for yi = 1:(size(Cell.Y,1))
        if yi+1 > size(Cell.Y,1)
		    y1 = Cell.Y(size(Cell.Y,1),:);
		    y2 = Cell.Y(1,:);
        else
            y1 = Cell.Y(yi,:);
		    y2 = Cell.Y(yi+1,:);
        end
		y3 = Cell.X;
		a = (y1-y3)';
		b = (y2-y3)';
		q = a'*Q*b;
		area = area + 0.5*norm(q);
	end
end