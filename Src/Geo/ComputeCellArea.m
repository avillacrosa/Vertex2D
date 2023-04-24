function area = ComputeCellArea(Cell)
	area = 0;
	Q = [0 1; -1 0];
	Ys = Cell.Y ;
	for yi = 1:(size(Ys,1))
        if yi+1 > size(Ys,1)
		    y1 = Ys(size(Ys,1),:);
		    y2 = Ys(1,:);
        else
            y1 = Ys(yi,:);
		    y2 = Ys(yi+1,:);
        end
		y3 = Cell.X;
		a = (y1-y3)';
		b = (y2-y3)';
		q = a'*Q*b;
		area = area + 0.5*norm(q);
	end
end