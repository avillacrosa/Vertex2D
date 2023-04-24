function PlotGeo(Geo, full)
	if ~exist('full','var')
		full = false;
	end
	figure ;
	hold on;
	for c = 1:length(Geo.Cells)
		Ys = Geo.Cells(c).Y;
		X  = Geo.Cells(c).X;
		style = '-*';
% 		if any(Geo.Cells(c).YDistance,'all')
% 			if full
% 				Ys = Ys - Geo.Cells(c).YDistance.*Geo.BoxL;
% 			else
% 				style = 's';
% 			end
% 		end
% 		if ~isempty(Ys)
		YsP = [Ys; Ys(1,:)];
		plot(YsP(:,1), YsP(:,2), style, LineWidth=2, MarkerSize=10);
% 		end
		plot(X(:,1), X(:,2), '-s', LineWidth=2);
		text(X(:,1)+0.05, X(:,2)+0.05,sprintf("%2d",c), FontSize=12)
		if ~isempty(Geo.Cells(c).globalIds)
			for gid = 1:length(Geo.Cells(c).globalIds)
				text(Ys(gid,1)-0.05, Ys(gid,2)-0.05,sprintf("%2d",Geo.Cells(c).globalIds(gid)), FontSize=12, Color='red')
			end
			text(X(:,1)+0.05, X(:,2)-0.05,sprintf("%2d",Geo.Cells(c).cglobalIds), FontSize=12, Color='red')
		end
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