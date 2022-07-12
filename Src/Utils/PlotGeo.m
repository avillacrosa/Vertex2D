function PlotGeo(Geo)
	figure ;
	hold on;
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		X = Geo.Cells(c).X; 
		YsP = [Ys; Ys(1,:)];
		plot(YsP(:,1), YsP(:,2));
		plot(X(:,1), X(:,2))
	end
end