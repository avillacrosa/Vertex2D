function Geo = BuildXFromY(Geo_n, Geo, Set)
	for c = 1:length(Geo.Cells)
		% TODO FIXME, seems not optimal.. 2 loops necessary ?
		Cell = Geo.Cells(c);
		Ys = Cell.Y;
		if strcmpi(Set.BC, 'periodic')
			Ys = Ys - Geo.Cells(c).YImage.*Geo.BoxL;
		end
    	if any(Geo.XgID==c)
        	% Updating a ghost node
        	dY = zeros(size(Geo.Cells(c).T,1), 2);
			for tet = 1:size(Geo.Cells(c).T,1)
            	gTet = Geo.Cells(c).T(tet,:);
            	for cm = 1:Geo.nCells
                	Cell   = Geo.Cells(cm);
					Cell_n = Geo_n.Cells(cm);
                    % Check if tet corresponds to real cell
					hit = sum(ismember(Cell.T,gTet),2)==3;
                	if any(hit)
                        % if it does, compute change in displacement
                    	dY(tet,:) = Cell.Y(hit,:) - Cell_n.Y(hit,:);
                        % Geo.Cells(c).X = Geo.Cells(c).X + Cell.Y(hit,:) - Cell_n.Y(hit,:);
                	end
            	end
			end
			Geo.Cells(c).X = Geo.Cells(c).X + mean(dY);
    	else
        	% Updating a main node
        	Geo.Cells(c).X = mean(Ys);
    	end
	end
end

