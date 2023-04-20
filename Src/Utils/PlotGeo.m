function PlotGeo(Geo, full)
	if ~exist('full','var')
		full = false;
	end
	figure ;
	hold on;
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		X  = Geo.Cells(c).X;
		style = '-*';
		if any(Geo.Cells(c).YDistance,'all')
			if full
				Ys = Ys - Geo.Cells(c).YDistance.*Geo.BoxL;
			else
				style = 's';
			end
		end
		YsP = [Ys; Ys(1,:)];

		plot(YsP(:,1), YsP(:,2), style, LineWidth=2, MarkerSize=10);
		plot(X(:,1), X(:,2), '-o', LineWidth=2);
	end
	if isfield(Geo, 'BoxL')
		bl = [-Geo.BoxL(1)/2, -Geo.BoxL(2)/2];
		br = [+Geo.BoxL(1)/2, -Geo.BoxL(2)/2];
		tr = [+Geo.BoxL(1)/2, +Geo.BoxL(2)/2];
		tl = [-Geo.BoxL(1)/2, +Geo.BoxL(2)/2];
		points = [bl;br;tr;tl;bl];
		plot(points(:,1), points(:,2), color='red', LineWidth=1);
	end
end