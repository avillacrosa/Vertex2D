function nicePlot(Geo_0, Geo_n, Geo)
	plot([Geo_n.Cells(1).Y(:,1); Geo_n.Cells(1).Y(1,1)], [Geo_n.Cells(1).Y(:,2); Geo_n.Cells(1).Y(1,2)], 'DisplayName', 'Start');
	hold on
% 	plot([Geo_0.Cells(1).Y(:,1); Geo_0.Cells(1).Y(1,1)], [Geo_0.Cells(1).Y(:,2); Geo_0.Cells(1).Y(1,2)], 'DisplayName', 'Equilibrium');
	plot([Geo.Cells(1).Y(:,1); Geo.Cells(1).Y(1,1)], [Geo.Cells(1).Y(:,2); Geo.Cells(1).Y(1,2)], 'DisplayName', 'Solution');
	legend();
end