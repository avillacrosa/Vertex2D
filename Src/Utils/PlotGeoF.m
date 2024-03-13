function f = PlotGeoF(Geo, Geo_0, display, g)
    if ~exist('display','var')
        display = true;
    end
    if ~exist('g','var')
        g = zeros(Geo.numY+Geo.nCells,2);
    else
        g = reshape(g, [2, Geo.numY+Geo.nCells])';
    end
 
	f = figure('Visible', display);
	hold on;
    YQuiv = zeros(Geo.numY,2);
    FQuiv = zeros(Geo.numY,2);
	% for c = 1:Geo.nCells
    for c = 1:length(Geo.Cells)
		Ys = Geo.Cells(c).Y;
		X  = Geo.Cells(c).X;
        Ts = Geo.Cells(c).T;
		YsP = [Ys; Ys(1,:)];
        if Geo.Cells(c).ghost
            % plot(YsP(:,1), YsP(:,2),'k');
		    plot(X(:,1), X(:,2) , '*', MarkerSize=6, Color='#8c8b8b' );
        else
            for ti = 1:size(Ts,1)
                x1 = Geo.Cells(Ts(ti,1)).X;
                x2 = Geo.Cells(Ts(ti,2)).X;
                x3 = Geo.Cells(Ts(ti,3)).X;
                conn = [x1;x2;x3;x1];
                plot(conn(:,1), conn(:,2),  Color=[0,0,0,0.02]);
            end
		    plot(YsP(:,1), YsP(:,2),'k');
		    plot(X(:,1), X(:,2) , 'b*', 'MarkerSize',6);
		    gids = Geo.Cells(c).globalIds;
            YQuiv(gids,:) = Ys;
            FQuiv(gids,:) = -g(gids,:);
        end
		% quiver(Ys(:,1), Ys(:,2), -g(gids,1), -g(gids,2), Color='red')
    end
    quiver(YQuiv(:,1), YQuiv(:,2), -FQuiv(:,1), -FQuiv(:,2), Color='red')
    if exist('Geo_0','var') 
        for c = 1:Geo_0.nCells
		    Ys = Geo_0.Cells(c).Y;
% 		    X  = Geo_0.Cells(c).X;
		    YsP = [Ys; Ys(1,:)];
		    plot(YsP(:,1), YsP(:,2),':', Color=[0,0,0,0.02]);
% 		    plot(X(:,1), X(:,2) , 'b*', 'MarkerSize',6);
        end
    end
    figureStyle(f);
    f.Position = [0 0 1000 1000];
end