function Geo = Remodel(Geo_0, Geo_n, Geo, Dofs, Set)
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		for yi = 1:size(Ys,1)
			if yi+1 > size(Ys,1)
    			y1 = Ys(1,:); 
    			y2 = Ys(size(Ys,1),:);
			else
    			y1 = Ys(yi,:);
    			y2 = Ys(yi+1,:);
			end
			l = norm(y2-y1);
			if l < tol
				% DO REMODEL
				
			end
		end
	end
end