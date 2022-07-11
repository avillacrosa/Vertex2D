function Geo = BuildXFromY(Geo_n, Geo)
	
	XgIds = (Geo.nCells+1):length(Geo.Cells);
	for c = 1:length(Geo.Cells)
		% TODO FIXME, seems not optimal.. 2 loops necessary ?
    	if any(XgIds==c)
        	% Updating a ghost node
        	dY = zeros(size(Geo.Cells(c).T,1), 2);
			for tet = 1:size(Geo.Cells(c).T,1)
            	gTet = Geo.Cells(c).T(tet,:);
            	for cm = 1:Geo.nCells
                	Cell   = Geo.Cells(cm);
					Cell_n = Geo_n.Cells(cm);
					hit = sum(ismember(Cell.T,gTet),2)==3;
                	if any(hit)
                    	dY(tet,:) = Cell.Y(hit,:) - Cell_n.Y(hit,:);
                	end
            	end
			end
			Geo.Cells(c).X = Geo.Cells(c).X + mean(dY);
    	else
        	% Updating a main node
%         	dY = Geo.Cells(c).Y - Geo_n.Cells(c).Y;
%         	Geo.Cells(c).X = Geo.Cells(c).X + mean(dY);
        	Geo.Cells(c).X = mean(Geo.Cells(c).Y);
    	end
	end
end

