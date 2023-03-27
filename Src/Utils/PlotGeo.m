function PlotGeo(Geo)
	figure ;
	hold on;
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		X  = Geo.Cells(c).X;
		YsP = [Ys; Ys(1,:)];
		plot(YsP(:,1), YsP(:,2), '-*', LineWidth=2, MarkerSize=10);
		plot(X(:,1), X(:,2), '-o', LineWidth=2);
	end
end