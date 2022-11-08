function PlotGeoF(Geo, g)
	g = reshape(g, [2, Geo.numY+Geo.nCells])';
	figure;
	hold on;
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		X  = Geo.Cells(c).X;
		YsP = [Ys; Ys(1,:)];
		plot(YsP(:,1), YsP(:,2));
		plot(X(:,1), X(:,2) , '*', 'MarkerSize',6);
		gids = Geo.Cells(c).globalIds;
		quiver(Ys(:,1), Ys(:,2), -g(gids,1), -g(gids,2))
	end
end