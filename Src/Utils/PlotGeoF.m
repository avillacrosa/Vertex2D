function f = PlotGeoF(Geo, g ,Geo_0, display)
    if ~exist('display','var')
        display = true;
    end
    if ~exist('g','var')
        display = true;
        g = zeros(Geo.numY+Geo.nCells,2);
    else
        g = reshape(g, [2, Geo.numY+Geo.nCells])';
    end
 
	f = figure('Visible', display);
	hold on;
    YQuiv = zeros(Geo.numY,2);
    FQuiv = zeros(Geo.numY,2);
	for c = 1:Geo.nCells
		Ys = Geo.Cells(c).Y;
		X  = Geo.Cells(c).X;
		YsP = [Ys; Ys(1,:)];
		plot(YsP(:,1), YsP(:,2),'k');
		plot(X(:,1), X(:,2) , 'b*', 'MarkerSize',6);
		gids = Geo.Cells(c).globalIds;
        YQuiv(gids,:) = Ys;
        FQuiv(gids,:) = -g(gids,:);
% 		quiver(Ys(:,1), Ys(:,2), -g(gids,1), -g(gids,2), Color='red')
    end
    quiver(YQuiv(:,1), YQuiv(:,2), -FQuiv(:,1), -FQuiv(:,2), Color='red')
    if exist('Geo_0','var') 

        for c = 1:Geo_0.nCells
		    Ys = Geo_0.Cells(c).Y;
% 		    X  = Geo_0.Cells(c).X;
		    YsP = [Ys; Ys(1,:)];
		    plot(YsP(:,1), YsP(:,2),':', Color=[0,0,0,0.2]);
% 		    plot(X(:,1), X(:,2) , 'b*', 'MarkerSize',6);
        end
    end
    f.Position = [100 100 800 800];
    figureStyle(f);
end